Return-Path: <netdev+bounces-78137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9C874308
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1301F23807
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AE51BC56;
	Wed,  6 Mar 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ry3K1Zsj"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C81B945
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765886; cv=none; b=eBMVlZO5CePWdnueJfW/JLi+9VX97nwaKceyT0iSvkuEIFpqFnHvENHH7PKBblvB35nSg/oppgZacujUcCN089fokIxibpheqejj93RvARs8JZde4by6HblYiEGrRsdADc3t6ypMiVDidAJTixmqtT2xn7+vx/JYaqUgP2HuCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765886; c=relaxed/simple;
	bh=pRgMq4lQPcX9OKB4pRDC3+8M1BDdsRWmg0YoxuHdxwQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=A6naBoE/NklVZjFGOrdQtdFR5Zk56qpI1NfqDqjxJoqySicB34NHtMlrylU0YhzCYu1s+LtyJYPd79ZTzVKm8ilmd2bskTA+W1uvlSNW2/PZzFVNKMYI3Y/0a5zFUp7X5d7cYx58rqtutAI+OMMtXAXlWx/0LYFSocYoIQ0ohpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ry3K1Zsj; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3E132C0061
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 22:57:56 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 81E8913C2B0
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:57:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 81E8913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709765875;
	bh=pRgMq4lQPcX9OKB4pRDC3+8M1BDdsRWmg0YoxuHdxwQ=;
	h=Date:To:From:Subject:From;
	b=ry3K1ZsjkUYMeu3Cg4z+QtkX/YbjGs3HpdBkmGr9xBCSGF/7eoxcg9cV0bQV5P7AM
	 wv4qd4W1zgtkFUupVF+ayn5IfeVsc8m5g3Hv/6mR8Cjx9sZkmU8/6JQlBGY6L0ZKgi
	 xwLG1rrPJ+DBugv7SmUUIXDuM1vdw6SO5fSSKWm0=
Message-ID: <a76c79ce-8707-f9be-14fe-79e7728f9225@candelatech.com>
Date: Wed, 6 Mar 2024 14:57:55 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: netdev <netdev@vger.kernel.org>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Subject: Process level networking stats.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709765876-FtmoWUgoUMlO
X-MDID-O:
 us5;ut7;1709765876;FtmoWUgoUMlO;<greearb@candelatech.com>;0590461a9946a11a9d6965a08c2b2857

Hello,

I am interested in a relatively straight-forward way to know the tx/rx bytes
sent/received by a process.  I do not want to play tricks with packet capture,
and I want this to work for some arbitrary process like a web browser.

I wasn't able to find anything existing for this, though perhaps it exists
and I didn't find it.

If anyone has pointers to existing work in this area, please let me know.

And if not, then any suggestions for best way to go about implementing
this?  I assume I should start poking in net/socket.c, and perhaps directly
into ipv4, ipv6 socket logic with care not to count anything going over
localhost??

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


