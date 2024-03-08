Return-Path: <netdev+bounces-78582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76365875D17
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310BE282114
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241352C859;
	Fri,  8 Mar 2024 04:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="reIT9Mmx"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444012C85C
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871633; cv=none; b=Hrh4iWBLq5NxS++aocFl7CMvf25uWSPwv+B5MHZdTWOlfVhDnLk9LhYoPcX8v/HYuuXlKlRK6N5nzOryMzkDCcLEcT7zk0+fdH9iB9SXZHuV06oKxv4lT7K3OoizmYmKYzvmV6oGYxwK5Q6Q//U4FX1acEikQITg7eE4b6rtbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871633; c=relaxed/simple;
	bh=3sPbcPHAeQvwgylDirUV1Ww/86KYlekUeG4vTlyjMh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJD7AdXJJZnidvnSVmd/m5We+GTlt1sRszefuHhY7Si5ZgrgRVRiuoQ1MBG32asL1MtTYLoOKlGwRZsisMDDLqEturIzpDN2SPM3eUAZ3IRZ/3bNibeX1qn0fBvcL3DW83K9jW9wg74TKMazppUUfrS5s67hnH18fm94EwrsZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=reIT9Mmx; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BA23180064;
	Fri,  8 Mar 2024 04:20:28 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.34.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E512B13C2B0;
	Thu,  7 Mar 2024 20:20:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E512B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709871628;
	bh=3sPbcPHAeQvwgylDirUV1Ww/86KYlekUeG4vTlyjMh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=reIT9MmxIyuGdWJ9O5kDshVj8LWyaaquF48XdFwIxGdOPyjCxX7HfnGue4QXIhzgU
	 EKGx6oNtFLdSSOWVcL2uZbZnnNqFVePa8My7ssIk4CTop1zuOt1Bz3VYJ/Q4um/QTX
	 NWe6ZbR9CQGe3BRCbl2dykIN5TtAO8SFrYnHs4IA=
Message-ID: <efc8358d-e666-4ee6-95d1-a6ccae6949d9@candelatech.com>
Date: Thu, 7 Mar 2024 20:20:23 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Process level networking stats.
Content-Language: en-MW
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>
References: <a76c79ce-8707-f9be-14fe-79e7728f9225@candelatech.com>
 <20240306195726.11a981cb@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20240306195726.11a981cb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709871629-2a2eTsLp6Qc3
X-MDID-O:
 us5;at1;1709871629;2a2eTsLp6Qc3;<greearb@candelatech.com>;734049c21285abfbb55dd56ad4f9dd58

On 3/6/24 19:57, Jakub Kicinski wrote:
> On Wed, 6 Mar 2024 14:57:55 -0800 Ben Greear wrote:
>> I am interested in a relatively straight-forward way to know the tx/rx bytes
>> sent/received by a process.
> 
> What is "relatively straight-forward"? :)
> You could out the process in a cgroup and use cgroup hooks
> 

The main thing is that I don't want to try to do it with packet capture.
Thanks for the suggestion of using cgroups.  I will look into that.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


