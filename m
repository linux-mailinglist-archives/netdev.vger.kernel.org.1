Return-Path: <netdev+bounces-288708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ceGxEZyCCWrJdQQAu9opvQ
	(envelope-from <netdev+bounces-288708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:55:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2AA5600A7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BD0730054E7
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD7C34D398;
	Sun, 17 May 2026 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sI14ZeKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7832E11B9
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008153; cv=none; b=L4bHHaCd9oxtYKniTxawPuPUeWHXinQ/w9ZyAkIaTBW37Xli724KlZxcRjzDgT1TjfV5amvxzPgJfYsqmHGjIkTTg/rd4aKaCKSJ5IrOQbYDIIfCZ/08JpaZJ8s19RCl4t/8IrOhBQbIs4eve9B/zO8O5+DQTLlmue+pCGiqY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008153; c=relaxed/simple;
	bh=98SxM9fDxCmEDO5Zptel2YipyQV4YoW2CMu1YvFbDJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s314NXlmtfCrNrM+NanVmnqWDfrSyM2ZrdrfqGaj12xsTOhyvd6LeGv4P1rb3IvOX2H4G8WHCfk/9Bl/3PYckEmliN6hkjcUepIVZbBDUPxwYacJB0ckmMLL4+AyBYWPGelO7mj3rFEjTC/5nYU+Cc53f+pA5KYMyOP95WNgMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sI14ZeKs; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcd9061b1aso1327867a34.2
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779008151; x=1779612951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/8mgb/DFhDo1SQISbAnkAt3iYpeBRt1y5CBxZBA4V4=;
        b=sI14ZeKspwASwWVWzrPz6ZgURx4os21XAixJdrVkIe7vqcWiE3wWRVhWstUv1L7hoQ
         x9JyHaicrh4lRzVLR95zy4//Hdhbd+G7bvBM/3mWk6m29SVWRfzfeuW6Wv/9IOJPerpA
         5zc6ET8xELu7NbwbCVWezN1SH+yH/XSEuZeIqX4q4tQermBtsscPpqo7EVSaWN2Grbwb
         cH0c7lB08o/5x4tlUrMoX8IQkZ3KyXKRQBxS2XCUnDzfDB8n3kfASAJf1wX6zyXrfea7
         VjGOOjMoimvX4SO/rwKJNkkB4MHByo7Q/IJoykXXcE0v2/LASPlRri9HtBy47Y6V8WN/
         c0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779008151; x=1779612951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V/8mgb/DFhDo1SQISbAnkAt3iYpeBRt1y5CBxZBA4V4=;
        b=ekUYlvxMElAw1m0IWgS3HXHA7R+7W9SlGceXVbcjFGlapOoKk0mBGUc7p89iULNgte
         kfMhdTT4Axhjv8TqsuMOLB3279OGKvLF357DwalZvN5PMYlwxNbYoTX0aDvveLpeTR9s
         fOpfFYcgZVW1RRfjXZDImOYnlrqhxGhNQRmfje784QvPN5TH8GHfjSmTUg6DSq1899rG
         ofG9ZnOV+u775Nm3kNfUaOZvrqFrZOpzXUtu6CkfuaNsTA32VF9aUzJvu7kds7IKMHs6
         omHi3SG4eZEugxSA39zBwolh42TJYx/exOiPj6DaO7EGlRTPjHIlsQP9wE11rFwjeJ9h
         HR+A==
X-Gm-Message-State: AOJu0Yy7qEiY//nptDOtXcPfofTiXYKPnX46C2LKrY3efiOVhG1923wO
	FKKU4Ss/mivnGRA6Ae4V6O5goHIoqEZvD1ENvlczWC0oq3d754juldcx
X-Gm-Gg: Acq92OGLhw+wHf/5B0XUlMYq6O2kp1CghkAgHmTC9Vy2sOFCHoNqtjSVKV9+t9xEyUE
	8S8+QyC1QrVtpTw0TgpjiYi5Y9R1VDhy/isxRch1IgJFgoxm4RP2EzJ/ilkqLSUo1/E5L9RS6aQ
	PM7kcrzKpuIh0F9oXxBfpBL8ium6QiNJ1u3w3JBwpJNnbDxA0QTq+zLHUrEM/tWd7Rx3DOwRTxX
	ZzLj1nrvtb13tIWclTBxztaND++egphQtgMyLEo0BhQ9Bxi53ZtFLqxA0sfbHgCuNKj7/JC98lI
	YSRGk4/ppceC8i5woNq3LCbIckgK1TMsBJX+S7h+Tm0Z49skM4zbzhlGyzor3JWC4NRV4PUcCsY
	WhD7LCuoR7U+KnFqJb++fv/aJmLbYPwIEKVwPRjyRP6i+8ZGn9h4pXClAZW8slSlNf3zEYCwucI
	sw1dvhcNuEgYzqtTA=
X-Received: by 2002:a05:6830:600c:b0:7d9:b189:d938 with SMTP id 46e09a7af769-7e4f2a43a18mr7504541a34.10.1779008150588;
        Sun, 17 May 2026 01:55:50 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4749esm5609609a34.23.2026.05.17.01.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:55:48 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@redhat.com>
Cc: netdev@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: Re: [PATCH net-next 0/2] netlink: specs: complete OVS family coverage
Date: Sun, 17 May 2026 16:55:35 +0800
Message-ID: <20260517085535.2129533-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517083358.2088599-1-houminxi@gmail.com>
References: <20260517083358.2088599-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA2AA5600A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288708-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Aaron, Ilya,

I sent the first two patches of the pyroute2-to-ynl migration series.
Before continuing with patch 3 (the actual ovs-dpctl.py migration),
I wanted to check if the design direction matches what you had in mind.

A few questions:

  1. ovs_packet.yaml marks key/actions/egress-tun-key as type: binary
     instead of nest, since ynl doesn't support cross-spec attribute
     references.  The plan is to load ovs_flow's YnlFamily separately
     to decode those blobs.  Does that seem reasonable, or would you
     prefer duplicating the attribute-sets (~600 lines) into
     ovs_packet.yaml for full typing?

  2. For upcall receiving, patch 2 adds ntf_listen() to pyynl so we
     can bind a socket and receive unicast MISS/ACTION upcalls through
     the existing poll_ntf path.  The alternative would be raw socket
     code in the selftest.  Any preference?

  3. The remaining pyroute2 usage in ovs-dpctl.py is pyroute2.iproute
     (tunnel interface creation) and NDB (interface lookup).  I'm
     planning to replace those with subprocess calls to `ip`.  Any
     concerns with that approach?

  4. For the ODP string parser (~1500 lines of flow key/action
     encoding), that stays as-is since it handles the human-readable
     input format.  Anything there you'd want changed?

Happy to adjust the design before writing patch 3.

Thanks,
Minxi

