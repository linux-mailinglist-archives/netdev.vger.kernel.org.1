Return-Path: <netdev+bounces-145661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B599D0535
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 19:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0DC28186E
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C33D1DAC93;
	Sun, 17 Nov 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="MYGzs1OK"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD83823DD
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868829; cv=none; b=ZyBDo/4g1/bwElFK5ExV5mWr+/nKkMt9vVOgfwI0naA9cXZu10ZFz4dx0Nf0Ww5NnTWCsStm8pCNWm7CJG+Jsly+8ttkOntpIGwxuUJxu4Uwz+IbVvu5RdAFM/KBzi1mHuj9xdEsYG/hgwUKtF2atH7Xkydvp9C/6cFrqPjz6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868829; c=relaxed/simple;
	bh=Ao9mynJkxgk8QrL1RlXXfX4GqrqDqJak8WR9vLGZk80=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rrAS2TC41zY61dp4kNnF4FZ32oqflgfEycyu9Go41tmr+eQBZyaFSx2lZI7gUa16zuA+qLVDF5QPzc5tgpRLMO4CBNKSMju506UdaV0HoW0gbEr0MhWwYDi1h0e2rF2fHSlczg+mp/WhuZBsVFNggDSrs9YGygrnJEJXTFWQu+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=MYGzs1OK; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0779C10006B
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 18:40:18 +0000 (UTC)
Received: from [10.252.34.165] (unknown [198.134.98.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 66EE013C2B0
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 10:40:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 66EE013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731868818;
	bh=Ao9mynJkxgk8QrL1RlXXfX4GqrqDqJak8WR9vLGZk80=;
	h=Date:To:From:Subject:From;
	b=MYGzs1OKANaoW24s3lqJnF+tfheR+JNkGigUD38WZz1dZuKwI0m+BHX6lZPbaiGGo
	 xQqRFXE2FOkv0GxhjvbP8h5GqdAcukvWRrA45A0uMEKUIqqNef7GDySmc/RQlrGng4
	 aXf/efku3NJbpY1tV3CXvsEQL+af7+V/PKq9PluY=
Message-ID: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
Date: Sun, 17 Nov 2024 10:40:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: netdev <netdev@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: GRE tunnels bound to VRF
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1731868819-irlW85hjI81F
X-MDID-O:
 us5;ut7;1731868819;irlW85hjI81F;<greearb@candelatech.com>;0590461a9946a11a9d6965a08c2b2857
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

Is there any (sane) way to tell a GRE tunnel to use a VRF for its
underlying traffic?

For instance, if I have eth1 in a VRF, and eth2 in another VRF, I'd like gre0 to be bound
to the eth1 VRF and gre1 to the eth2 VRF, with ability to send traffic between the two
gre interfaces and have that go out whatever the ethernet VRFs route to...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


