Return-Path: <netdev+bounces-88207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B4C8A6537
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DD1F226D5
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4771B50;
	Tue, 16 Apr 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVH5r1Fv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836333B78B;
	Tue, 16 Apr 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253006; cv=none; b=ChyOzkvew5NPc/1faONgo6izeA5i/RloTiUjwWqkfmWcfN/ZOC2dz2WCH6WoWyLyTSkIcBywt6d8i9dD8dHziK0+UY3FsSy5GqdpXNiGKFSBWNYQ3ZWwe/AsFAFvWA1a+zTnyWNQMS4X/b5Ln9HvflILUb9Jiy2aVgL7XVZdJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253006; c=relaxed/simple;
	bh=h/lQtZIwrELyNxzNTszhRhT4BgUCCZ1e32RY0cQ9Q5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYh72NRmTB3BOVd067oONpDbW3fmCKN7KmzkNtTjdAxv1iwK0qIyEMAJLWjARULVDX8xqsR2pE20KxLeMfKN2Vqx7uAhH2J4wR6h4o9TPM6XtZ0Q3eIEzCZloZeXywn8AMjOSbZxVk6Ux0uH6/lSosSM7J12SsG4ukCeXPPOJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVH5r1Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1BAC113CE;
	Tue, 16 Apr 2024 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713253006;
	bh=h/lQtZIwrELyNxzNTszhRhT4BgUCCZ1e32RY0cQ9Q5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mVH5r1FvjpCPVBYzALfue5Kp9J/MxTu7fH6Hnc4jVCkJaE6Qf3bzX0kRRnStW4fsf
	 /UNMNiIAozJOneZeuLR+L5yW5Ol4v2wl4+J1AHrlsWkDJMvE1svFJt2GFjHSwetnyE
	 yWqhtP5Qc1++hfocHGC/+CWHGRJgcxppW2MAXuRVa5/vNeXIv3aEdkxRbmAGFnZeof
	 9uapHa6Ibo3Wj6Mc2alCu+3sXT+mZb7V9ohTx2N1guyt/WktZg4H5LZn7YlkchZd7f
	 45xD7AYDl2qZokAEq111tdXXs0Mb2AL0lyGbSTJF/hHtCW8n539yeZug9kYP44a46R
	 7Hr8I+/zOeUNw==
Message-ID: <35c0e6dd-ad60-44e6-9f25-00362a5095c7@kernel.org>
Date: Tue, 16 Apr 2024 09:36:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2-next] ss: mptcp: print out last time counters
Content-Language: en-GB
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Stephen Hemminger <stephen@networkplumber.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20240412-upstream-iproute2-next-20240412-mptcp-last-time-info-v1-1-7985c7c395b9@kernel.org>
 <69e00bd0-a1d7-4021-ada9-9d344e0e84e4@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <69e00bd0-a1d7-4021-ada9-9d344e0e84e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 13/04/2024 18:45, David Ahern wrote:
> On 4/12/24 2:19 AM, Matthieu Baerts (NGI0) wrote:
>> From: Geliang Tang <geliang@kernel.org>
>>
>> Three new "last time" counters have been added to "struct mptcp_info":
>> last_data_sent, last_data_recv and last_ack_recv. They have been added
>> in commit 18d82cde7432 ("mptcp: add last time fields in mptcp_info") in
>> net-next recently.
>>
>> This patch prints out these new counters into mptcp_stats output in ss.
>>
>> Signed-off-by: Geliang Tang <geliang@kernel.org>
>> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  include/uapi/linux/mptcp.h | 4 ++++
>>  misc/ss.c                  | 6 ++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
>> index c2e6f3be..a0da2632 100644
>> --- a/include/uapi/linux/mptcp.h
>> +++ b/include/uapi/linux/mptcp.h
> 
> uapi headers are synced using scripts, meaning at best uapi updates
> should be a separate patch (the updates can also be omitted).

Sorry for that, I didn't know. Thank you for the explanation, noted!

>> @@ -56,6 +56,10 @@ struct mptcp_info {
>>  	__u64	mptcpi_bytes_received;
>>  	__u64	mptcpi_bytes_acked;
>>  	__u8	mptcpi_subflows_total;
>> +	__u8	reserved[3];
>> +	__u32	mptcpi_last_data_sent;
>> +	__u32	mptcpi_last_data_recv;
>> +	__u32	mptcpi_last_ack_recv;
>>  };
>>  
>>  /* MPTCP Reset reason codes, rfc8684 */
>> diff --git a/misc/ss.c b/misc/ss.c
>> index 87008d7c..81b813c1 100644
>> --- a/misc/ss.c
>> +++ b/misc/ss.c
>> @@ -3279,6 +3279,12 @@ static void mptcp_stats_print(struct mptcp_info *s)
>>  		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
>>  	if (s->mptcpi_subflows_total)
>>  		out(" subflows_total:%u", s->mptcpi_subflows_total);
>> +	if (s->mptcpi_last_data_sent)
>> +		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
>> +	if (s->mptcpi_last_data_recv)
>> +		out(" last_data_recv:%u", s->mptcpi_last_data_recv);
>> +	if (s->mptcpi_last_ack_recv)
>> +		out(" last_ack_recv:%u", s->mptcpi_last_ack_recv);
>>  }
>>  
> 
> applied to iproute2-next
Thank you!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


