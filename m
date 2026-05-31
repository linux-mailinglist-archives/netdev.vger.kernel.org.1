Return-Path: <netdev+bounces-293434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MfQIv1KHGqqMAkAu9opvQ
	(envelope-from <netdev+bounces-293434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:51:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100F616B7F
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA343023DA3
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16F38F620;
	Sun, 31 May 2026 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnga+xti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E738E5C8
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239048; cv=pass; b=kPYr4Jml7yewWqTtzmCpJW2x3SWQ4MkiJpcw5yxpIF502w+8g95idw33cb2v046qCg1JNEiKnocq6Yqb7goo82MDr4fbHyxj2VA9NsFBCImzQ0RrC9fN7Qy0EHsez67oFWUjExMOwEDAsC8M8V+mYM4m0VtTT8CnehA4JDWkFjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239048; c=relaxed/simple;
	bh=00TEAGz86ZinNxtNPkYkxSIq5f6e1VKR4IZ8aV+ckg8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PfqMOWcxQFiI2E64tGb+MQIOCg1ImW/NAj5ZTW9lgtiwgsZY9s4w0T8YeTLDIdhyhkzv16ODRmuVuKqZ3b0PYZbO0LXhsjtiSpE4dLjwOHhupxAiX++dd5jRcmnBC+/y3H2s/j+WpbwT61xwZG1hD8cnn142ithRx1MGzaLuWZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xnga+xti; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so1904255a91.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 07:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780239046; cv=none;
        d=google.com; s=arc-20240605;
        b=cbTdbV8+/8K7SoM8Yh2bvXkmvgSnysbBFgKP4yn5wUH4flx1AIu2AWEbkCu+Gm1Cij
         Gz+LDMoaotiORnFDMDZ0BxCyvgzzp8U2JEdGuNvk5RTO1F0sc9DnP6cJF2DgeaDgN1wY
         H3qeTYUsNZRwCLAMcbBvgklPE7Fe2r44UqWsQxecnTSUlj6zVhYNzsp/oUpxNCvJy+P3
         oEthZq0ckOpNhlkyfjZuJkZkxOtwAm90lyzDztvoxUmd0d2zykRIF588oGF4iYVAjzDC
         RpltdRCesernY2mcep9RtebsiDTGS/N2gxzmBCScH6nPqaiJpK9bvTalsq/zLsXIbOKC
         W0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=alr0cevSmwlVQXo691+fLjwg6MiDECX2vWqD7VKBSjg=;
        fh=s8GRSxc2fw6UZoGToUgvXE37Igt2PJxmjtuQSmJ4VZo=;
        b=LVZi70Y0jv8NGb03sGR1K1UaxvdaRgfZ6suvjf+Ry+CZ4YfTsO7rRXnEQ5hfHJNytj
         CHtSiq234Of3H2EAmlt9CuIQCiAySIJIm9h/0qo3nwfZrbQd0M3oNEjc0Tq7osnnXWpv
         m6WoZ0oWPkGC6ku6Xq8hcAol8vi6MP6YUO82q6pKn3mlfWvvi5BV2lAiz2IGImxAMq9r
         7Ukvg9IiWJdJqmCKcyXRFZEkvngxQ8iBPljZvRGOKbVJPxrN+5GCHCpvaOQW0MlDJdb5
         /3B+b9465qBP5TndscY5K37bKOBupq6sjruxAPP/CKgFK8a62XmTFWp8uUEMldy51cNB
         9n4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780239046; x=1780843846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=alr0cevSmwlVQXo691+fLjwg6MiDECX2vWqD7VKBSjg=;
        b=Xnga+xtiHRsAogwf9fB5VCAvpr92CVAdpffKnsPaLK1dVNJJb5PY38wp6zybWwdY/C
         FkQJBxopnpRadJtKMKSHkcPUoKtdovX+RAYCoqMcWX+BwB20BnfXqd0fJs0hSg95fPEW
         kZvb53LRPW7amXEeVDXOaydj//crMye6wQFRWKX894W4Bkqq8IaKd08QIxej4RADO6Yq
         CIH5OO2W6q/LmLRXF96BeLKgOwQ9GXFcxS0zFQEIEPaFAejqo4WtytVK065s9SLDwgRI
         PFb8a1/YLxugDk1Pb6Ev16K5YNPvlspaxKWvsQrS9yKhrUymeDXg3e/x6rdHPOYQXxqe
         t0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780239046; x=1780843846;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alr0cevSmwlVQXo691+fLjwg6MiDECX2vWqD7VKBSjg=;
        b=XohQYp2+WozMyaQZjxW1ICTA4aw3suWJMdw2h+BTQC4E9/Rj1UsdC6ypVMmfZh0tb3
         j+Pjfjg8t0+m9slzVqpuzzKDwncuWV9R6UrgfYKFcLc3Fkd44hl55422mZ3O0077CPCi
         mOlUu71y15AEt5ITuSzHkBmwaOhSrLD60i5dO1/VHxAeiApSorkx+6qsrK4ED56oE+b8
         Q1xfUd0VtuL4AePeK4263kmf/KwHx6xX2x2CTMLAlRuKrxnVE2QPWXI1pgq3BRCYdxJ1
         u62AWa4RkQ1quHoUrhQ18GkRE/rrnBYqSNoOxdIlHaSfP9lqIwBNNL+pldvgAphoByl2
         UkZg==
X-Forwarded-Encrypted: i=1; AFNElJ9ujcmAwSEoUGPEv720tOaz2RuBdLNKbdiXgmKasTI6o0cw1Eta6/R3Zng5tJE/kAdPEQhw6eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPpxMxGVE6daw80BrID6eKBwYNQ2cI7Z+QoD8gxkQnGQXceye
	iz6ZyAow5sZvNAS9J8ePxGrHJJwo7+HALQF15VmGwOXmeoLc70UlDzIwwEZmsi20oYW2sHZpcsc
	4MWUp6vf3V9sPnnGTjC4dpIY+hs0I01mefseuGZU=
X-Gm-Gg: Acq92OEabqZ3MAmTAcC71C18JHtni+YwDoPxsvtjQmJNSmaqg1Y8tA2w+UcfWm1gIQh
	+HQWRpTo8okSv6JRR7m/9/aSxbpztbCFG4LKljlP7LX9jY6cUzyfLy3u3yJP61kR02Qn+uE9UGw
	YMipUnnNcTOnNwTJLaftZiEv3j19eKsVFMpUSmeRYmvudWyZiuckedHuSj7kHgKFWNluGdKCNN6
	FPM00D/GfFIS8oBf/nooxTJnuBWL+HjMhO8YJ0Xg0/c4FX0yPS8L7qVvUCrfpFYN5ayf7x/2pNJ
	TaelXno+1bESV3DdgLin0/0gK7eCcPY=
X-Received: by 2002:a17:90a:d2cf:b0:36d:649b:ea46 with SMTP id
 98e67ed59e1d1-36d649beaffmr5225695a91.2.1780239046249; Sun, 31 May 2026
 07:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Grewstad <dogestad24@gmail.com>
Date: Sun, 31 May 2026 20:20:35 +0530
X-Gm-Features: AVHnY4I0bdqKDSDpbxtaHikPCrAQjQXtcW7k-UTC0757o0c6aHNjTsyA3G1MFds
Message-ID: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
Subject: [RFC] drivers/staging/axis-fifo: TODO file and subsystem direction
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org, jacobsfeder@gmail.com, linux-staging@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	hjk@hansjkoch.de, davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,hansjkoch.de,davemloft.net];
	TAGGED_FROM(0.00)[bounces-293434-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dogestad24@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1100F616B7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Maintainers,

I am interested in contributing to the Xilinx AXI-Stream FIFO driver
located in drivers/staging/axis-fifo.

While reviewing the driver, I noticed that it does not currently
contain a TODO file describing the work required for graduation from
staging. I would like to create such a file, but before doing so I
would appreciate guidance on the expected long-term direction for the
driver.

The driver currently exposes a custom userspace ABI through a
miscdevice. While this provides a generic interface to the FIFO, it
does not integrate with existing kernel subsystem tooling. One possible
incremental improvement in this area could be a transition from
miscdevice to a proper character device (cdev) interface, to allow for
a more clearly defined and maintainable userspace ABI.

Some possible directions that came to mind are:

- UIO, if the intent is to provide userspace control over a generic
  AXI-stream FIFO with minimal kernel policy.
- IIO, for data acquisition or SDR-oriented applications that could
  benefit from existing buffer infrastructure and userspace tooling.
- Networking, for packet-oriented AXI-stream use cases.

Before drafting a TODO file and proposing patches, I would like to
understand whether there is a preferred subsystem model for this
hardware, or whether the current architecture is expected to remain in
place.

Any guidance would be greatly appreciated.

Thank you,

Arihan Bhor

