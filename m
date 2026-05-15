Return-Path: <netdev+bounces-288299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP/6GsAUB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:42:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA21954FC79
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FEFE327FAC1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877C3446C0;
	Fri, 15 May 2026 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTFWe1n+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DFC30674B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847362; cv=none; b=rS7O0jTCILpiQ1hvG2+3J/SlKBOnORML+emHSiyGNsbO8jM8zT7NlzQ+QsPf9N4ijYFzhxOJGYPEtq6c2jmzvnuXdmeLoMkkjDImbNvTtHq5dDuAby0iNXtOSqBE5z/L7Qe+1ygt4PVtVyrEOZYDczq/bHu45Ly7zz24cU0X12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847362; c=relaxed/simple;
	bh=PhF5sqKXVHCPVXY+C8Jt10W1quSEWWvCVve4FW/jfKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ho8qrCeiNsN8ELsKQ550ccR9eMxJm62CjIuq031q5fEywqiuFgfq/0WJzwkMEBaJwts6FMOJ3OGxPbZKewK4/4dIM7lBFeoKkvpMbQmUtY8NObRTAk0tDn2uA8zMyX8xspkdh2u3fDZl1+qNiAG7TM7s6cV90+0OjS/kaOmUO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTFWe1n+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe62837baso4734385f8f.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847360; x=1779452160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mZiI1XugEd12IRDZ4O5hUJueT5qAnNWt069Fm2GMds=;
        b=UTFWe1n+58caUHbncwP4oB1xbNtVwtOEZ7rvroQ0/lOjpSRTPj6FImJzgVtUTCZxug
         gJRX4RFvHfV78QzQLOGjZmXfW5AZ4TZ8zKZ+vWLzMq2Ot1xemf8cKOLbSDN+NY2X3IHa
         TdHyRqn2lSZphdlPQrZ1DLoi5ZMq6zqA/WdEqskESw/NE4hsmI34miOfjgapIuneix7i
         auMda1KJGYZ2/qncnjqSQxBGd8amQB4Y1+xdK/SqL5zOJ65g7Rkt+BArGpRGcaVEWm+N
         Y0StPesY4OfgV40uWh89t5arYazxqENAV6ruSp89D7fLVYk2h9DtMj+40QJNPHqyVHJ/
         LzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847360; x=1779452160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mZiI1XugEd12IRDZ4O5hUJueT5qAnNWt069Fm2GMds=;
        b=OWlIZpPW8X6fpVTObLSm2an0IydpBJuMGI8XBPUpw5O+5DRRDYducNHz/h/tUke2bF
         i9x/jdirsaMPrgluk87A25sV9YLMMFw4qh6HYH6GWTRCxVap8FtQlLEb6LBkR26cVrzx
         LZn+JepI5QPrWUMIsONKIB0tOS3i6JwypnhB/nAtzJ9Pe6Ng6d6Q0yY9dzNdDZHl0xev
         W9OPWms6Cq4KozO1dqBsRIl3ahu/k8FtRpCr8odXIJRBM/+yIpbQYHsN90BOUXy+BhxF
         pmScntBztAMOcbzar7CLuWvL5PbmCGwhquZcCdML/iL6aF9B+a9Zi7FNjJH8xJY7R5Dy
         ynbw==
X-Gm-Message-State: AOJu0Yze/oSV8NaE9jNfHRm5piH77TCnw5yhgCs/ThsSP3dfy0u0GOuZ
	0mWnx1KAnhnmAx2xcIyX8Z3PK4uh+mfwrR+I6YEoBnSIzKOUAgAL6fdcr6IScoy1
X-Gm-Gg: Acq92OEIS9W+u7/v8WZvAs1m8XYwXhA04ZW+zDfVWUmb7xqVI8RY1OvfCw76vY+yCUK
	rAhoKZvmsGOP83RMHrVxn2PLNU/jJGtwUHcFRGD7uE4RSjIg/muyBd+qHW0cuV8x2EcBQ8gticC
	Hui+najn06UFfXCbVA4almcaTdS6rMpZh74iom+U7ZWUx+bRwDikzooH1ndKmbkD4gP8sDbdkYe
	s5UQhPShzBOmQly9LSHE+GYFhkjPOO5avXi0jntdn2npDS79Droz3Wdt03EooS26CCpiRPoiVb5
	jKlamzur8lmWbw8OrVj7AtzwTQ6K0Nyo864eSGfDNH714G/DYZgIp6hXtE/vzpcZzY06HvTveeu
	62AheEzSgmkjrjOvFzUjxQkfLVTNI+uccDddy6c8PTvVES/8BVJuPOhP1yVkBTvCOz6FqInlQtw
	KunXq3294t+oHo5zvAWWC7hLxaUgBQB6PMchL95+FDYAkmteTf5sQvZY0=
X-Received: by 2002:a05:6000:2288:b0:43d:781d:37b9 with SMTP id ffacd0b85a97d-45e5c5ae8f2mr4798748f8f.42.1778847359596;
        Fri, 15 May 2026 05:15:59 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm13728226f8f.11.2026.05.15.05.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:15:59 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: netdev@vger.kernel.org
Cc: bjorn@mork.no,
	andrew@lunn.ch,
	linux-phy@lists.infradead.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: Re: [PATCH] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge before assuming MDIO_I2C_ROLLBALL
Date: Fri, 15 May 2026 14:15:57 +0200
Message-ID: <20260515121557.17925-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260515121108.17792-1-petr.wozniak@gmail.com>
References: <20260515121108.17792-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA21954FC79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mork.no,lunn.ch,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-288299-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

Please disregard this patch — it is a duplicate of:

  https://lore.kernel.org/netdev/20260515115527.17241-1-petr.wozniak@gmail.com/

The original was sent to linux-netdev@vger.kernel.org and I received a
bounce notification. I incorrectly assumed delivery had failed and
resent. The original did reach the list.

Sorry for the noise.

Petr

