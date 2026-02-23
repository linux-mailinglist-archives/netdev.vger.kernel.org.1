Return-Path: <netdev+bounces-260012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN/YKntCnGk7CgQAu9opvQ
	(envelope-from <netdev+bounces-260012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:05:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10818175DBB
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07CD8300B87E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF39361643;
	Mon, 23 Feb 2026 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="EB4qaD7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B634F48F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848313; cv=pass; b=sIAjQ2eEkhIpR8+V7cbJOID47biMM1WjaWFjtYdAJ3A6h8/UOUheCAnbek83rPp1jntwiizd5XD00XjyF4kwihn2zdXcdcl1UGcbsymCk+wTtzioCQ5JNazYTIqTEeBD9zOkXAciTusRjtvYi9zOow5/0jGVHzmc90Y5WkIa53g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848313; c=relaxed/simple;
	bh=i7XcdVJsjCl2l1ptPdxBvnBqAy36rdQFH89kgs/EtKk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KOOmDQVxtsG+nYqwRpjDKYaK/BK+khTCIGeEASCNfJ6BYSvvuLJ8s6vsy6dr2H0YTfQyqypFBMu2bGi5u+9qMe0T4t24uU14os/PRXalzePu5rUMa1Yj7xJO2OSgIoo8vaIN9pHP6cQRdCSX1c3rdk4o1IDKdMS/8bscVOLazCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=EB4qaD7U; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65a26c220b6so5332647a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 04:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771848310; cv=none;
        d=google.com; s=arc-20240605;
        b=Ukw16TLNg40UeOdc5mIIswrHMVnytXxq3QwXMDNQ51fDkbvheA9nl5KkjLooT7i8a2
         JgymQtnRu2tQ7oZYUdNkvBQPww+8J1E0KGx9zrkU2ZDvzgDCPFnZ00Xmf4jXJFmRjgGz
         V1GCrgdYS42yUPCGoyGWydPQns9fVWIP8ua+NWitB5uNGd97K2yo0vdGZ7JnYbqa9B+x
         nKfT9WoyAQRW5HIcyMa/v2n3DiYLSfTLoP5pxoeRsojtEIUdBr6fuA5QonUjU3cgruor
         WwVjwZB0dZY6ldUu7Nt5lGf9SG4KdtZOKgFCOuBQt6+7QU1mZmuZos8Zc1qukWa26ihE
         9zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i7XcdVJsjCl2l1ptPdxBvnBqAy36rdQFH89kgs/EtKk=;
        fh=bZPknvR4uFTGSR/4QKfAaOFJC97hwoQuHlGY0Kp8WBA=;
        b=CaxYFwBqv49qkODKHKMUUEtg9UJHOUYmI/y4DW7jK4OMI24Bac2bzuFKdqc84CkzUj
         MqNGvSAZC958T7ldJeYLSz859bQMig7IdIotDc9yXvsMr3fZowUglPxuGeajgT09/M5j
         6H9rc94BMfU6evy6ixBw2DQa23hQc8On5Xna8Xzcy9mZmGxki2YuVTouAFs/HarZJlL+
         BDc+et4Nmp/2K2mpTSdWjyhZA0Yawe5tmghAxVY3oTJedNf95XvUX7/aJ9h90PM14fhx
         13Ynyer0pqGh/k9CPmd4bqn691UdR74s3meL959l/jMH1bi6aeYESLbNDyLLO5LVnKbF
         gFsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1771848310; x=1772453110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7XcdVJsjCl2l1ptPdxBvnBqAy36rdQFH89kgs/EtKk=;
        b=EB4qaD7UfHoTSm7Yx9+ddO5MR8u/x9/adHQrc1mn7FyCX4WNJ40h7/739yZ8JHiGlZ
         gZolSGKc917i8Q8msogC9p64Mp8wdt73tWOYpIrZHAYyqKnGvEzcJ+SPNK36dbGJ0+rm
         ltjocauHGatFHoKC2r8e7KZqFjnueqODNnkGiazqmq8ly2EJEbOofX41V0PLx2zvwn/G
         Q9bnw40vR7lyQYLp2L+PwUzAKUogC5MJw7M8MSXk/yz0Tzw7EFT4/+HhjpzUc7jT9TJe
         rtb1yf8P+L74tAgJwLdXu193jBbYHv6KsQiKqTWG4bySAcrtXwVQ+u5B2y3D/LXDXiZq
         Czyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771848310; x=1772453110;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7XcdVJsjCl2l1ptPdxBvnBqAy36rdQFH89kgs/EtKk=;
        b=IKS41QWYPzTsePGkP9F8U0qEU3tbViN/OImAKijf9XfUCls2uOSXrz523a69+OyETE
         een3eHYhc2cVdldeTrZmuBGmz1kfcvZZvwh+n4pxp7LcAxfmLBDbIq3ENL00k1T38cXD
         T/QN5sxLbTgwOmJlhVATTSAOQDxK9Mebo/Z1I2VwU5H/E0v8xdG/vSlXTPmIjsJMTj8h
         uJ4QoVEgjgCoqp2mL7nmbp76rWl4bA4X6WL3+46U80KhqDFo7Kh6nYqSpSKi5BQ1w7US
         mjEULKmojSXDBT5pWCpM8CmdTdEYdMmFVhRrRgwi1Hsc6x6grQ1OXQBYsz59TBl1KGsI
         xdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNbn11IMOYUgDcsmO438jvD3QJ+hFMWQbJz82Mw8pXec4rIBHJEBVNUFR3D1ILmn7mQWnO+zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cE6BjFttiPKmDFdybAIKFsMOmSi9pCNdkMkdlnMHjei0Jpku
	0PxlQeW+LRp1Jje2OB1rkRT+OGiOAdiBaiqZ2JKTQL6MgHPT+fksSMTBDs2mq77mLtMgFiMZpgb
	4s/ty5dZmYQDt7ztnfG7pIDtk3k8M5jdjtc5lwy2DGA==
X-Gm-Gg: ATEYQzxvWuAWMuBN0VlNDMrMSejgL0sWVK9XphgS48d7Xt1zPtdzA+8HMbvGOEu/msg
	j/B1b36vPiyFt3qKlqUU8WQ7hYA1gEhTxGhAu4KopcNkANkmv6EhvK2AnbhaiQKoUOVj6yOWL9s
	rvhlzV8zGmacGfZFXFaNkCNzc0/N73BK++W4B8ubJORpXxnZXGunBkFn/0XbDJuiCK3FKrV8vKl
	Tu20VSJmSuCB9eN/m6h0J+ph974kERpcPQYjz9l1QNRnK22J5MhALs2O4bBkg8Gp/9dObIuQ/GI
	SvNQeftMndYMA89jL6GKGcM=
X-Received: by 2002:a05:6402:354b:b0:65a:cdfb:58a7 with SMTP id
 4fb4d7f45d1cf-65ea4ed0c0fmr4607110a12.9.1771848309707; Mon, 23 Feb 2026
 04:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
Date: Mon, 23 Feb 2026 13:04:58 +0100
X-Gm-Features: AaiRm53zToqsx-zcDAcAHBPZanTLxK-IdyrpisVR804xGPajSGNbIsfetSDKgOo
Message-ID: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
Subject: commit 662dc80a5e86 breaks rmnet over usb
To: lvivier@redhat.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[citymesh.com,reject];
	R_DKIM_ALLOW(-0.20)[citymesh.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[citymesh.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[koen.vandeputte@citymesh.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 10818175DBB
X-Rspamd-Action: no action

Hi Laurent,

I'm testing the latest openwrt state and found an issue probably
caused by your usb mtu limit patch :-)

I'm talking about this one:
662dc80a5e86 ("usbnet: limit max_mtu based on device's hard_mtu")

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.12.74&id=662dc80a5e86b35bbf339e0b87b7cc3f07c09de1


When using wwan0 iface normally, this makes sense, but the problem is
when using QMI modems combined with the rmnet driver and aggregated
frames.

- The modem is configured to frame sizes of 16383 or 32767 using QMI
- wwan0 (using qmi_wwan) is configured to match this frame size by
setting it's MTU to the same value
- Frames of this size are sent over to qmi_wwan driver (containing
multiple data packets)
- Frames are then forwarded to the rmnet driver
- Frames get de-aggregated here and sent to the network stack for processing.

The reason here is to reduce USB transfers heavily.


As you see, it's perfectly possible here to use very large MTU sizes
as the aggregation feature by rmnet relies on this.
Also the modem can be perfectly configured to send very large aggregated frames.

After your patch, wwan0 is limited to 1500 bytes it seems, effectively
breaking aggregation.

On my tests, download speeds are reduced from >300Mbps to ~.8Mbps

I also made a build reverting this patch and all works well again.


Is there any other solution to fix this?
I guess it should be reverted otherwise :-)

Thanks a lot!

Koen

