Return-Path: <netdev+bounces-79647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA9C87A5F3
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079B12821B3
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7020A3CF72;
	Wed, 13 Mar 2024 10:33:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CF3B299
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326008; cv=none; b=Q+dTh/NN+rsYsbG8y+BiJ7fQNiLjfyyFnO6wRgv7l0PpEhq4QdK7yJkdW3sIQL4sy2idlzOBrVu59eOAPSGnTLTCPOsnrZMKgt5cgRPhTrbesQfrKK3sTl9xCbhPOCJ7dmCjWaAnoXLHY3TI//6+cP1mJmuctt+qDhcLfP0MfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326008; c=relaxed/simple;
	bh=PXpzzP5ViQlWQObT//CgNI3zDMN7Kwl3InH7F86+66k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BXb9yP2iTGtYafvUMbV7sk9Us5vnBp0gYoLm/moQ3Fdks+H45tVQebsT79l84dEZ+JIz1jEyUAOsc1qd/+Mjkd/wuZir36ffS0VidA29Be8jPaaaE1VF0LV7lbasbfx+wA1nSId7c8YcxEn4sK683qu2gAQTI+UjouCw0Up32PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from mail.qult.net ([78.193.33.39]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOiLp-1rRpN10nq3-00QBXI for <netdev@vger.kernel.org>; Wed, 13 Mar 2024
 11:20:24 +0100
Received: from zenon.in.qult.net ([192.168.64.1])
	by mail.qult.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1rkLih-0005CU-JJ
	for netdev@vger.kernel.org; Wed, 13 Mar 2024 11:20:23 +0100
Received: from ig by zenon.in.qult.net with local (Exim 4.96)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1rkLia-00Ca5p-1K
	for netdev@vger.kernel.org;
	Wed, 13 Mar 2024 11:20:16 +0100
Date: Wed, 13 Mar 2024 11:20:16 +0100
From: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
To: netdev@vger.kernel.org
Subject: Issues with notification of NUD_NOARP neighbor entries
Message-ID: <20240313102016.coqdw4n2q5ms3a52@zenon.in.qult.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:nNhgcRqOxVgmiH+3+mPhJUPK2HNAKqAqIMMmA+I76YuJzCFsbRx
 ZBx1MugP5kK7aMHgYDGW+pw2PXRvdJKqSL/o25I2wTvSH9ZjEdbgWj6ZLn5j2QvcY/BLLBl
 J4YKhgyo+AN83hRnLZnV8oa93eCLYk313qmDR7CrEK1TSTnUikreX1JKo8705n+pfMgLTfU
 itifYgaV6LxJRMxNqoGEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fKmNmBVpDCo=;TMiBx+E9yuk1etf0xdlWMLOOOVG
 +GmG4w9w2xO0Cs7UCvDqt+NVDl6eTin1d50YYVj9V4C5wquZbwSetPvfzD1ZXtIKGT8C5cqgQ
 3FoDs+aVmEKZYswjLn2ZhyFjRbu7f2yQiBPjSzZa2Fxyl66GJClIjbN1q2fSyGYmFA6Pijr/q
 IDrWbLVzYZjqkDANcdsjIx5U9KBSP4bisJHBH4feE2RaZnHNXJxo2//0Mjkk+SDhz0lfIevGn
 GIySrUtxwLFMnu7dTNmD6bL1HouPfvwikL5w80Jb/Hkh0053fND+2DI7OdWbVowSLqPToNBgU
 Ca5U/JORjumKXv77D6JCWhWU888bZYF+OE3bFBt3rBiQKZx4oCYsGWg+ugDFQaTSreJnZMRg8
 rWilYEyH+8sZ2l5KAubMUL3416biXgxjQJRu3bikEAV7Bh8ERixVdTqDiF07xIlN5siWK6Z07
 aOUopUhn3z0eOsAKOMBk4hKGacOdFFi+KWwEGmLu545ZNchNc1zaHjjoIS1ntZptH3jM/VM7G
 VIbHTs7HhHdsvorykxt3pXKpfXj/nG9uwU59HG8aTT4sMBilk8lqP32IeGuJyS8XSxojH5M0q
 k73AdZcn26y3q1SgyMJ0mgdoFRVmB4p4X6uFI8qN9cE3qToHolCVYsTTNgQTXnnyGCmyXI/YP
 Mqh5/RNCAXopLzz2vXF4MC+hNgFhtcrCX07kdBqSag0hZjcxYyfEWM64oWfjyjSJyggDTqOv6
 N+Cz2TeK1eN86+q26R8bXczkmMLXToyDcFu+heT6ome/d3r9MRSQik=

Hi,

I've stumbled upon several issues with the way NUD_NOARP neighbor
entries are being notified on netlink (as reported by ip monitor neigh).

First, it looks like NUD_NOARP neighbor entries are not notified with
RTM_NEWNEIGH upon insertion in the table (either by the kernel or
explicitly using ip neigh add).

Second, if such entry is explicitly removed from the table (using
either ip neigh del or ip neigh flush), then the corresponding
RTM_NEWNEIGH is sent right before the RTM_DELNEIGH.

Third, when such entries are removed by the GC, only the RTM_DELNEIGH
is sent.

This is at least the case with 0.0.0.0 and any IPv4 multicast address
entry.  I haven't had the opportunity to test with IPv6 just yet.

By looking at netdev archives and recent commits, it looks like these
issues have not been addressed since kernel 6.5.

The neighbor management code is fairly complex and I would like to
know your opinion on this before digging more into it and attempting a
fix.

Thanks,

Ignacy


