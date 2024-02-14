Return-Path: <netdev+bounces-71681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B956854AF9
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1A61F2553C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205954BE8;
	Wed, 14 Feb 2024 14:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125754F83
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919210; cv=none; b=FN5EHo+yszsHkZD+QOrgH5KKR83adBQXZ/mnzVGTc7VMzhDwRdZLenVnb3WK0A8ReFZIKsl3GEIjNzo1C2hKfnGde5Vj5drY63r14PtN1wqbQhrKkC/GhoBXjY8XwZ/EbyovIcTCj/MQFGMXpMkyQt9sCFYSJvj282YMgGapYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919210; c=relaxed/simple;
	bh=LrAhrgLibqt0Ou1fB6NQY6Ne5+nXRkE71jIe4qTvnQI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=dCtNXVrosIBY5E0VrwrjBVfzh0s9QJlcKC6IMD7X58eLHcbcI9fqztGc5sPvMnbLrmJu2ED8Pdxxn74rKWbR5mXYw7+63EM1Bhod+jNYy81rhDxlpKq9PNK4dYh2FpSmbS/Pk7NSLBB4PQ0YLo4k0hN0GrNVGIoG371Wp7hWbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inf.elte.hu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33cec919bfbso319776f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 06:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919205; x=1708524005;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrAhrgLibqt0Ou1fB6NQY6Ne5+nXRkE71jIe4qTvnQI=;
        b=weUrupIkQOi0feXZXmjyCkpoSbV76PMpgc8sv0i6UUqFEqnOzdvCs0F+hPB/kYWVi4
         sfshOk5xDMSD4sG78F9f34Tgwy/ztZgmbGlJXWYiN12ee6Nk29z9p3rbEbvKpvKY/j13
         bKKuNnI79m99j/qhlAyUuTr6cPDvuL4XwvkNRD2YJHn8Beuo4vkUpImnkKSIDtCpznQQ
         qyqU7s2OMxRaPZ+xsC959gyafVCRAX+5M1Qr/dt1QFt8LqDGe/vVTl7fNz1kccLPOTEr
         lYtsPIMv5xyXRAGrbBkTBxJeRr8/kUacZP5B8ZoDPOrLCDgCwyYFoGQMM25Vrf1lbVQ/
         6KOw==
X-Gm-Message-State: AOJu0YyYee9hS/APihL605x/clfkv6+j7/YemHjzEgDyUkiM53ybTtWc
	NonETUqzzJW6tCaRW1aXOEW1WJHY4RpufQS9oi0Q7fNzwIz3uyijGSSSRrewPYA=
X-Google-Smtp-Source: AGHT+IHTl/E3vkQ1u2f8RP3fq/yt26b8sSxbXOOTyjDdI2H+gJ4WM8WX2HYxFsBf0JzIG8qAyLMzKw==
X-Received: by 2002:adf:ce03:0:b0:33c:e339:23e4 with SMTP id p3-20020adfce03000000b0033ce33923e4mr2106492wrn.62.1707919205326;
        Wed, 14 Feb 2024 06:00:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZEAylDqqHQHdOudSErCSSj579ouHQsycyZ8Fk9bLUJmXiFuZUB3Pbhi1gkOYALyiqCJSR5pvYs30WYkwUe76I2JRhQ1ZppMB8bSfW8YD81u3GgA==
Received: from [10.148.81.47] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id e12-20020adf9bcc000000b0033ce9e6e8easm2053892wrc.32.2024.02.14.06.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:00:05 -0800 (PST)
Message-ID: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
Subject: igc: AF_PACKET and SO_TXTIME question
From: Ferenc Fejes <fejes@inf.elte.hu>
To: netdev <netdev@vger.kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, Kurt Kanzenbach
	 <kurt@linutronix.de>, hawk <hawk@kernel.org>
Date: Wed, 14 Feb 2024 15:00:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

We are experimenting with scheduled packet transfers using the
AF_PACKET socket. There is the ETF disk, which is great for most cases.
When we bypassed ETF, everything seemed ok regarding the timing: our
packet received about +/-15ns offset at the receiver (now its the same
machine just to make sure with the timesync) compared to the timestamp
set with SO_TXTIME CMSG.

What we tried now is to bypass the ETF qdisc. We enabled the ETF qdisc
with hardware offload and sent the exact same packets, but this time
with PACKET_QDISC_BAYPASS enabled on the AF_PACKET socket. The codepath
looks good, the qdisc part is not called, the packet_snd calls the
dev_direct_xmit which calls the igc_xmit_frame. However, in this case
the packet was sent more or less immediately.

I wonder why we do not see the delayed sending in this case? We tried
with different offsets (e.g. 0.1, 0.01, 0.001 sec in the future) but we
received the packet after 20-30usec every time. I cant see any code
that touches the skb timestamp after the packet_snd, so I suspect that
the igc_xmit_frame sees the same timestamp that it would see in the
non-baypass case.

I happen to have the i225 user manual, but after some grep I cannot
find any debug registers or counters to monitor the behavior of the
scheduled transmission (scheduling errors or bad timestamps, etc.). Are
there any?

I am afraid this issue might also be relevant for the AF_XDP case,
which also hooks after the qdisc layer, so the launchtime (or whatever
it is called) is handled directly by the igc driver.

Best,
Ferenc

