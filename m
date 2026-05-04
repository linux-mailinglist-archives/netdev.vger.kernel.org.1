Return-Path: <netdev+bounces-283754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DWhEuxd+GnatQIAu9opvQ
	(envelope-from <netdev+bounces-283754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:50:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF354BA8A0
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC55430471E8
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53934BA57;
	Mon,  4 May 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="gktmWMMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F23491DB
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884500; cv=none; b=iEdlXGiBHiKsrhm24NPOeVlavFU/uuNbe2BKgHjVBj1GHwBynDUJfXWCtFS+FiJEhxq74Js+fv1oVScuq2m5dXxvvNBc2pYCMm87YoTka70W5hIp72SZUg4sjMHaI59j81Mpo7lZrpMlr+wLg81JlPqTfH7HK7ZZaw1I4Dj6EBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884500; c=relaxed/simple;
	bh=bLUccklgBubfjMF9F927WmSX/x9egmRdCcgt3JBFY80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV5mMQmgXR6P1nTCUSuuDgZeR4aKLvC8hBIPs01Duso9KMwzkwFcNkhcII4uuMOSIj/Trz5i57drXO3QodjbJheDmbYCU8BjpCIeut0HYtEZMXHHolNM79VU2f43DQtnDRrRg/R2sZJB2jxwQ3SlFoRjjWgYRzVm2r9R5LaM/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=gktmWMMm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so26333705e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777884495; x=1778489295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLUccklgBubfjMF9F927WmSX/x9egmRdCcgt3JBFY80=;
        b=gktmWMMmQ6ZMu18AJzugEYu3wh2PAKxmnNIQknr4FN9cJ8Q1Cj+Z7P1A7sJL4jDw3v
         ngsPhUFTOM4LdVZHxtePRtxqJBzAwOVtBLDz/ZkVFblYcaWqFXSo/sF8pBR/pY8SI4wl
         qmH83NPMfxtSR3ZIoE6z1IBUt1RbAnuFLvzHxBqzv1QxvbrEaLR+1gXUKuhPPU10AoXR
         QP3KqBC3oz58i31k9f3s6qwKdPqTLDHBWzxlTeyMwb0i7N90hnyGR4nsCT927hITPe6t
         /yLnXWlnVK2+/XiSZQ0jjB3l/I1yviapkncr37GOjF2IRiI6bMK8risVHZ11QyI+eEb2
         Cf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777884495; x=1778489295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLUccklgBubfjMF9F927WmSX/x9egmRdCcgt3JBFY80=;
        b=hKqxekIoakJ7mwuflpjCKqyjbhz9hcL1DWndwgwgGMToVt2V79s2gc9CPh71NDn0GE
         ok1tEW2UwJrhfIARv0TM/9Bz9QKYIJb3aaL/9swv1RsVHyz2i2AxJDEWqIqONOHGSf5t
         lSnXrIDLI+LGA8rthx5EYTkBMydIAqhbdeCHvG9qMzTuciPalskQiU5UWyp9IHwNQLxj
         Rattrdx4JGFvvnnNJDPaCThXYEN9Ccce/G3s6YuWj6NZAhbx2eNXmHGYfR/zcXQM4+KF
         THPqW0EmY69PbTANfnGLcKSeR3yWvYYIpEHutMBA2OWht1DzpFel+O4NbokvR2kWnCww
         nbJw==
X-Gm-Message-State: AOJu0YyRhTtUCXF6C9n2O4QT6/r+SQYkRfMU9gTOArKgjOaA2Nw0M74E
	Fd1jg6bQcpbxMK0A/0l5Be/CgF00CHuherSR0VwUmagJEPnzanVUUgPzmiHx6KowrB8=
X-Gm-Gg: AeBDietP8zZuCP7UIwd8pMifBjTjNXD/AQUXrJFI+JDNr/xWomS8tKCEXPY+mZhtzK1
	1eIwSGuO/vNwk9al60XNXcD5wQd7/Idk7HPk/GkgUCEPfL5cjtqC7qQXqLD/mT42MhxcLQT2XNQ
	EyNy8LPnEAbBWhglqRdacsXExWa2kw4CzWuncMDJZHGe50YVlLUQKYQnQ3dv/x2ZOSwSrf3l/Ij
	UJrRECYndrJmA4rsSX0MGa6bBfKHYwm7RmJMbtr27M9rfkMJ2re8wLh0YMTw229Wg8AS0tqMzT5
	892YU6dTyh6089eK5830zQdmJ7QrMN3NaGGAXgKBDQgQSRUlvizCHBLg34ha8CRCeMd5YqFip5U
	dVfii8b/cEs3rU5EREUHcTyC3xY0Nq9/JQNxVp/GLKHv5oGXquz+2OGWharEBChGFxgZfVW78iE
	/olPd1ihOXIixOjE+6Ps1foApAvZe9pyOoyrA6afPT0XY=
X-Received: by 2002:a05:600c:26d2:b0:48a:5236:7f38 with SMTP id 5b1f17b1804b1-48a8607970fmr159836115e9.14.1777884495283;
        Mon, 04 May 2026 01:48:15 -0700 (PDT)
Received: from FV6GYCPJ69 ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44b63d78692sm20604340f8f.27.2026.05.04.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:48:14 -0700 (PDT)
Date: Mon, 4 May 2026 10:48:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: move
 fractional-frequency-offset-ppt under pin-parent-device
Message-ID: <afhdCnT0ns-PgZD8@FV6GYCPJ69>
References: <20260430173611.3312596-1-ivecera@redhat.com>
 <20260430173611.3312596-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430173611.3312596-2-ivecera@redhat.com>
X-Rspamd-Queue-Id: EDF354BA8A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283754-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Thu, Apr 30, 2026 at 07:36:10PM +0200, ivecera@redhat.com wrote:
>Move the fractional-frequency-offset-ppt attribute from the top-level
>pin attributes into the pin-parent-device nested attribute set. This
>makes it consistent with phase-offset which is already per-parent and
>clarifies that FFO PPT represents the frequency difference between
>a pin and its parent DPLL device.
>
>The top-level fractional-frequency-offset attribute (in PPM) remains
>unchanged for backward compatibility.

That is odd. The ppt one was added just for higher precision but was
semantically the same. Now you change it. Could you still treat both the
same?

>
>Distinguish the two contexts in the ffo_get callback by passing
>dpll=NULL for the top-level (rx vs tx symbol rate) call and a valid
>dpll pointer for the nested (pin vs parent DPLL) call. Update mlx5
>and zl3073x drivers to return -ENODATA for the nested context they
>do not yet support.
>
>Add documentation for both FFO attributes to dpll.rst.
>

[..]

