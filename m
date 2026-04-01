Return-Path: <netdev+bounces-274240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH+8GqhvzWlsdgYAu9opvQ
	(envelope-from <netdev+bounces-274240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E711637FC3E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 21:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8AC7305D2FF
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA62DB7B9;
	Wed,  1 Apr 2026 19:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender-op-o11.zoho.eu (sender-op-o11.zoho.eu [136.143.169.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACC2C11E4
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070942; cv=pass; b=OfGnh5McYOF0c9WdBV++3nmVmSlskuS7odQ+u/NlEJWrvJ3IQe6W1EfNy4YeHQVYmwHp2PNnUDbERhN9SDWvmkGrd4CKpRSjz8djBqnZBLyLODZRSPgn4cHPAJdqhubzUfMiw/IFdPLbtayiEezVycK4aaUgT88ROLm5aofIfuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070942; c=relaxed/simple;
	bh=ITR9t5NNz9TG31O7Y7Wi4mu4tF5FStHyNwHwvo2AGeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4und2F3tGueJCoZNarp4C/FNmzQWPhFpF0C9ehlXTxQ3YL3pKSM3DPuogxYP3O7kDIl4Z7X1U5dTUH02rmUuPJ99G0KGl5r8hEhTS948Ar+L7F+aD9ml0sWawdFsXPqUenoMFw5YZTsOTnHY3Ha519Zpny6JJfS3DfuJMEkbvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trained-monkey.org; spf=pass smtp.mailfrom=trained-monkey.org; arc=pass smtp.client-ip=136.143.169.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trained-monkey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trained-monkey.org
ARC-Seal: i=1; a=rsa-sha256; t=1775070918; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZsfYi8Hcv50joNcckFLh8PTJjuIN/JRrRwOkKaCcLkzzDPsf6JdDAx95CJPHUOQu1L3G4vrihteRP1lGCzMGaB81M3GG/P56zntMyLPU8nA4ars1VWgCO3y1+/Myo7DTQx8SGNwbs1/rtHB1rxZpO4jPewCLSunGAEA8P0dnsOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1775070918; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KxB+ISWZnVfS3ItyTXfjYVQH6PPnc0Qla09RPC1/G84=; 
	b=gaez7r/ivrsmr7DcF5pVeUEkpkKPoq0jb1uZXKKgyZ4fE/CNpMhw+PRwrLR6o33aTSoiBzYmwpS4udpzrg57u43etdGCU3jOUaQx76J/cwhgTPl0WdqrC/1DX2fLejVs1+6E55ELSxzU2qMMk23KF1fBb/kjAdiMdQ5aiemYWhM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	spf=pass  smtp.mailfrom=jes@trained-monkey.org;
	dmarc=pass header.from=<jes@trained-monkey.org>
Received: by mx.zoho.eu with SMTPS id 1775070916441762.6499044645909;
	Wed, 1 Apr 2026 21:15:16 +0200 (CEST)
Message-ID: <0b0f9fbb-1c43-4891-8c11-7d51c54ec321@trained-monkey.org>
Date: Wed, 1 Apr 2026 15:15:14 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: alteon: Add missing DMA mapping error checks in
 ace_start_xmit
To: Jakub Kicinski <kuba@kernel.org>, Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_FAB2A00E105488F503DCC787B8060F881E06@qq.com>
 <acxcGhzbNsHdK49W@devvm20253.cco0.facebook.com>
 <20260331184144.7643062f@kernel.org>
Content-Language: en-US
From: Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20260331184144.7643062f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.946];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[trained-monkey.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jes@trained-monkey.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274240-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: E711637FC3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 9:41 PM, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 16:43:22 -0700 Joe Damato wrote:
>> On Tue, Mar 31, 2026 at 09:48:41AM +0800, Wang Jun wrote:
>>> The ace_start_xmit function does not check the return value of
>>> dma_map_page (via ace_map_tx_skb) and skb_frag_dma_map when building
>>> transmit descriptors. If mapping fails, an invalid DMA address is
>>> written to the descriptor, which may cause hardware to access
>>> illegal memory, leading to system instability or crashes.
>>>
>>> Add proper dma_mapping_error() checks for all mapping calls. When
>>> mapping fails, free the skb, increment the dropped packet counter,
>>> and return NETDEV_TX_OK.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>
>> Is this fixing a bug you've seen in the wild? If not, I'd probably drop the
>> fixes tag and send this to net-next instead.
> 
> Either it's worth fixing in net or its not worth fixing at all.
> 
> My preference would be to try to delete this driver completely.

The amount of hardware out there that is functional at this point must 
be in the single digits.


