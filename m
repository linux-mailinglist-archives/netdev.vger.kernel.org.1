Return-Path: <netdev+bounces-260582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHtWMDzOnWn4SAQAu9opvQ
	(envelope-from <netdev+bounces-260582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:13:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C81189A2B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F27B301953A
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581C73A7833;
	Tue, 24 Feb 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9/c75dG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4138BF60;
	Tue, 24 Feb 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949468; cv=none; b=Wpz4VnHDukhJ8WWtdhVJNJQfBy18/38NSlvfazjDyJuSWzsshlKDBZO1uGSUiboLuIgGy7T88aQC4pnNbAVqvqGSW0jiQqt3YjBht1+NfZzv4CF6xXW3MKMCuVxtnYqDZXynMvNhsYzyKnlG3meeUvgr05fiJmDbUf7IgqlcCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949468; c=relaxed/simple;
	bh=fdhBT8l/JcKIXS2ne2lkmrwsuR/CTkT5ozhsuLKERZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+q5rRsL5m0yavAQA+Yy+9C7uxUrmqsUSHf6hwO68PeE/0cSbiEUtxsnW+9gcsgg2vtf+fM2JhztB4qEe+nqvq+ax8ua5kV9cqQm00zhQgDkuV3DHn36TEAcIJB9OL6RssKBruDs0TUJW2wYIptbjjqibSfruGOqE42FruA1BN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9/c75dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A80DC116D0;
	Tue, 24 Feb 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771949468;
	bh=fdhBT8l/JcKIXS2ne2lkmrwsuR/CTkT5ozhsuLKERZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M9/c75dG8dszOV0z1Be56sld1x/t2ZfPsTWRDI1P85Kk523WNOmba2nuMGKc+1Jku
	 M856aa+x0L/FpI2uLf1hx4XYG3e6JlSkl02y6jCbB8Ky35lWiOog5eECUG5FqzLJ1f
	 gZAy3eoMsogHzIThoAmlfOCcdUlWhFL77GKhTJDIoG07WLzl/chn5dHkFtnkkLOHeR
	 pQPXkmYgU6FbGH2Z4wiDmFKQR3fWW1gWw8ffZh+kdvgI0BF66s4lOFYzfcPf8WeZDF
	 1j+9jtzdwHADBkrH3xGU6vBW53yyCiwzPtZjBJTGd0SXDCVrhh5oOBlMxJDC6nRkmA
	 hdsf7LRfmjK6Q==
Message-ID: <c43286ec-90fb-4d3f-830a-e3644be3c310@kernel.org>
Date: Tue, 24 Feb 2026 17:11:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/ibmveth: fix comment typos in ibmveth.c
To: Dave Marquardt <davemarq@linux.ibm.com>,
 Abhilekh Deka <abhindeka@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260224153601.17534-1-abhindeka@gmail.com>
 <87v7fmyvjv.fsf@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <87v7fmyvjv.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260582-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43C81189A2B
X-Rspamd-Action: no action



Le 24/02/2026 à 17:07, Dave Marquardt a écrit :
> Abhilekh Deka <abhindeka@gmail.com> writes:
> 
>> Correct spelling mistakes in comments:
>> - Fix misspelling of gro_receive
>> - Fix misspelling of Partition
>>
>> Signed-off-by: Abhilekh Deka <abhindeka@gmail.com>
>> ---
>>   drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 3108bf50576f..b2a578e6ff31 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -355,7 +355,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter,
>>   
>>   		/*
>>   		 * If multi rx buffers hcall is no longer supported by FW
>> -		 * e.g. in the case of Live Parttion Migration
>> +		 * e.g. in the case of Live Partition Migration
>>   		 */
>>   		if (batch > 1 && lpar_rc == H_FUNCTION) {
>>   			/*
>> @@ -480,7 +480,7 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>>   	 */
>>   	if (!reuse) {
>>   		/* remove the skb pointer to mark free. actual freeing is done
>> -		 * by upper level networking after gro_recieve
>> +		 * by upper level networking after gro_receive
>>   		 */
>>   		adapter->rx_buff_pool[pool].skbuff[index] = NULL;
> 
> I'm not quite sure why this was a v3 of this patch, but anyway.
> 
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
> 

I guess because there was a v2 5 minutes before with a misspelled 
subject "[PATCH v2] net/ibmveth: fix comment typos in imbveth.c"

