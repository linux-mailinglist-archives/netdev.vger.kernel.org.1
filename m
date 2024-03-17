Return-Path: <netdev+bounces-80236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D087DC1B
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 01:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4765B281838
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 00:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010337E;
	Sun, 17 Mar 2024 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lynne.ee header.i=@lynne.ee header.b="eimkY/RU"
X-Original-To: netdev@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E536F
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710635704; cv=none; b=MKtE+z+SFumfngJvNwqTK7iX5vfvU4EkPV2A/qbPJdUtvuGA4C/bMolL8dfTMMjlZeS4nOugKQL0X5LvMDujnHiUeJzn8zO998HbqITufaepkX6lK9ggcbukEfr/kXjw1CQKl9gfDY5z5rozUFD9fMRgGkNFpjB9Ch6ohvtL+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710635704; c=relaxed/simple;
	bh=VGUJSmEep0s7WFAbjIR6f67stVzu0Mm21CpnSxwThqw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=G47Zch2lB9XSks+MdVXY1r/FM2odi12ttCk1lN7+Fdfbx0DfuEq4y31CXfX84KMPjO9iNcjpGzoQH0lkNHeYyY96m+siqK7eaDhHKsJC2JYrOHJZCunfXfVD7vLCLj0V2Z7ftxGGt9vrPvrh1oBaBV3DdFIahdMTb/fhcJTAYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lynne.ee; spf=pass smtp.mailfrom=lynne.ee; dkim=pass (2048-bit key) header.d=lynne.ee header.i=@lynne.ee header.b=eimkY/RU; arc=none smtp.client-ip=81.3.6.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lynne.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lynne.ee
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id CF4E810600E8;
	Sun, 17 Mar 2024 00:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1710635690;
	s=s1; d=lynne.ee;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=VGUJSmEep0s7WFAbjIR6f67stVzu0Mm21CpnSxwThqw=;
	b=eimkY/RUZub3QBKEkoH9/3bKFoD8R4lmA8mn/inMK5ptnMnWUcqX9A8nkW2iGcnG
	MJtlbBaL8eipD+elWZZtCu5fNT6gUlXthkzy1r14veD5dLGKhN9m9t27e9ux6lwadkb
	b9PMMEAqfBE4LCV3Hs11fMbxtVDR3w0disgViowtsmiDgHMVPrKYQqkCuED4ONBQqLq
	SoVDmsktpNCYmeh2hiLCoJ6nixciX26+LNU7TK+lC/R2wL42RnnMI3GNBqVGdvznaDR
	2/IEwXJ0gZTix6aqy8oWQcsK0TF+p6xcCp77kd3KRseiqM2xSmH2EMqwa8HVl74Mw+O
	3ajndukrxw==
Date: Sun, 17 Mar 2024 01:34:50 +0100 (CET)
From: Lynne <dev@lynne.ee>
To: Netdev <netdev@vger.kernel.org>
Cc: Kuniyu <kuniyu@amazon.com>,
	Willemdebruijn Kernel <willemdebruijn.kernel@gmail.com>
Message-ID: <Nt8pHPQ--B-9@lynne.ee>
Subject: Regarding UDP-Lite deprecation and removal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

UDP-Lite was scheduled to be removed in 2025 in commit
be28c14ac8bbe1ff due to a lack of real-world users, and
a long-outstanding security bug being left undiscovered.

I would like to open a discussion to perhaps either avoid this,
or delay it, conditionally.

To give some context, UDP-Lite was designed as an even-more
unreliable protocol, with limited CRC coverage, to enable
very low latency multimedia transmissions. Due to roundtrip
times often being longer than a single frame's duration, it
simply becomes impractical to retransmit corrupt packets.

Instead of simply not showing a frame, it is preferable to
allow corruption within the packet, due to video decoders
themselves being resilient to bitflips, as any differences
within the frame will, at worst, fade away over a number
of frames due to prediction.

UDP-Lite was slow to reach adoption, mainly due to
broadcasting companies still using SDI internally, rather
than IP, and popular applications's own protocols,
like Flash (that one) using TCP (RTMP) or HTTP (HLS/DASH)
instead. MPEG-TS over UDP was preferred for point-to-point
broadcasts over the internet, partially due to potential issues
with incompatible gateways.

An additional limitation of MPEG-TS was its large vulnerability
to bitflips, with it only supporting 188-byte packets, and most
of it being packet headers full of optional branches affecting
demuxing, where a single bitflip could result in missing more
than a single frame due to corrupted state.

For the majority of consumer broadcasts, UDP itself
has only somewhat recently started getting traction, due
to WebRTC becoming a standard.

Due to the limitations of video transmission becoming
more and more visible, as the whole streaming ecosystem
and standards keeps improving, eventually, I think, it is bound
that a use-case will arise for UDP-Lite.

I am an FFmpeg developer and, alongside assistance from developers
from other organizations, VideoLAN and Xiph, we are working on a new
transmission protocol for multimedia, called AVTransport.
The specification can be viewed here: https://cyanreg.github.io/avtransport/
UDP-Lite specific streaming details are on chapter 3.3.2

It was designed from the start to take advantage of UDP-Lite
at its minimum permitted CRC size. All its vital packet data
(such as type, length, timestamps) is protected by LDPC codes,
and not only collections of frames, but individual packets themselves
being able to have FEC, allowing for minimum latency transmission
even over wet unbalanced strings, and meeting the requirements
for long-term archival.

The protocol itself is still in a draft form, and its reference implementation
is only just starting to become functional.
UDP-Lite is already supported, and is tested. The specification actually
recommends using UDP-Lite over UDP, due to the protocol's robustness.

FFmpeg, has also supported UDP-Lite, for RTC or MPEG-TS, for a
very long time, and I cannot say with certainty that no one
is using this without letting us know. What I do know is that
someone cared enough for it to send a patch.

Other operating systems still maintain their UDP-Lite implementations,
and have made no deprecation plans yet.

At the very least, without UDP-Lite, someone may think of a new,
possibly proprietary way, once this problem is encountered.

Given all this, I would like to ask if it would be possible to maintain
UDP-Lite support, even if only partially. I would be fine with its CRC
coverage being fixed to its lowest value, or even doing reviews for
patches or bugs submitted to the LKML.

At the very least, there is already a way for users to retrieve raw,
uncorrected UDP packets (by settings rx-fcs and rx-all on network
interfaces, which most support). Perhaps some compromise could
be reached by giving users the responsibility to check CRC themselves?

Thanks,
Lynne

