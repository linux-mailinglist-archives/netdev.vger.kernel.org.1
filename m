Return-Path: <netdev+bounces-304006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QAsCF88NRmptIQsAu9opvQ
	(envelope-from <netdev+bounces-304006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:05:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC36C6F3FFD
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:05:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304006-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304006-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70FF6300FC8E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3438F630;
	Thu,  2 Jul 2026 07:05:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480C38F945
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:05:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975939; cv=none; b=j1eif2lu9eedlkQnAkTMTexupBkqBxC1RDkP8qz9yFiLYxwBZQYZvpwDq8M3qElFqI5GK28FB59jZiUK14RoWtJciO1jE2kGJXVAHSq9JNngleB1BmTErT8vVkmIlLTzkrAKIsCLZJqbZuHSTG86sYhVX/9hwvkg8UNnPzCHdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975939; c=relaxed/simple;
	bh=b8P1gAhVWl2gjJi3fXh7iFoT6mSxEr6QODkwOCA7CBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwLNGlQKgzOzlBbwP97eaz3UXXvdA5pGT3/DKq7/4kBYZTae3Jd5vf8L4NuGYojxWxf6Jt0ghtdfvS7EmDm3NOVOwpBzP7kTh9t4lm6M3E2PBFEenCQzQUiVh21rEPY2xH5E7O/4AcjJUshXEeWHYGUVH4j+TMKqSKV/b+L0wrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 684c998c75e411f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4bf09062-0d05-4400-b7f7-446d8884ad66,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:26c9664204f3eb6a2b90aebe4cb1b8d5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 684c998c75e411f1aa26b74ffac11d73-20260702
X-User: weirongguang@kylinos.cn
Received: from [10.42.20.136] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <weirongguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1660990033; Thu, 02 Jul 2026 15:05:28 +0800
Message-ID: <bc2c7b23-bcaf-4c10-adde-753ede92b7a7@kylinos.cn>
Date: Thu, 2 Jul 2026 15:05:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ice: use dev_err_probe() in ice_probe()
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Rongguang Wei <clementwei90@163.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch
References: <20260701013618.29934-1-clementwei90@163.com>
 <akUmFsLra3VpRNPg@boxer>
From: weirongguang <weirongguang@kylinos.cn>
In-Reply-To: <akUmFsLra3VpRNPg@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:clementwei90@163.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[weirongguang@kylinos.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[intel.com,163.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weirongguang@kylinos.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC36C6F3FFD



在 2026/7/1 22:37, Maciej Fijalkowski 写道:
> On Wed, Jul 01, 2026 at 09:36:18AM +0800, Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> dev_err_probe() logs the error and returns the supplied error code, which
>> allows probe error paths to be written more compactly.
>>
>> Use dev_err_probe() in ice_probe() for error paths that currently print an
>> error message and immediately return the same error code. This keeps the
>> existing error handling semantics while reducing open-coded logging and
>> return sequences.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> ---
>> v2:
>>   - Fix commit message per Aleksandr Loktionov's recommendation.
>> v1: https://lore.kernel.org/netdev/20260630032537.42605-1-clementwei90@163.com/T/#t
>> ---
>>  drivers/net/ethernet/intel/ice/ice_main.c | 24 ++++++++---------------
>>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> Could we also address rest of sites within driver at this very same
> commit?
> 
> drivers/net/ethernet/intel/ice/ice_dcb_lib.c-873-       dev_err(dev, "DCB init failed\n");
> drivers/net/ethernet/intel/ice/ice_dcb_lib.c:874:       return err;
> --
> drivers/net/ethernet/intel/ice/ice_main.c-4482-         dev_warn(dev, "Failed to initialize hardware after applying Tx scheduling configuration.\n");
> drivers/net/ethernet/intel/ice/ice_main.c:4483:         return err;
> --
> drivers/net/ethernet/intel/ice/ice_main.c-4543-         dev_err(dev, "Fail during requesting FW: %d\n", err);
> drivers/net/ethernet/intel/ice/ice_main.c:4544:         return err;
> --
> drivers/net/ethernet/intel/ice/ice_main.c-4961-         dev_err(dev, "ice_init_pf failed: %d\n", err);
> drivers/net/ethernet/intel/ice/ice_main.c:4962:         return err;
> --
> drivers/net/ethernet/intel/ice/ice_main.c-5192-         dev_err(dev, "BAR0 I/O map error %d\n", err);
> drivers/net/ethernet/intel/ice/ice_main.c:5193:         return err;
> --
> drivers/net/ethernet/intel/ice/ice_main.c-5206-         dev_err(dev, "DMA configuration failed: 0x%x\n", err);
> drivers/net/ethernet/intel/ice/ice_main.c:5207:         return err;
> --
> drivers/net/ethernet/intel/ice/ice_main.c-5244-         dev_err(dev, "ice_init_hw failed: %d\n", err);
> drivers/net/ethernet/intel/ice/ice_main.c:5245:         return err;
> --
> drivers/net/ethernet/intel/ice/ice_main.c-9627-         netdev_err(netdev, "Failed to get link info, error %d\n", err);
> drivers/net/ethernet/intel/ice/ice_main.c:9628:         return err;
> --
> drivers/net/ethernet/intel/ice/devlink/devlink.c-1244-          dev_err(dev, "ice_init_hw failed: %d\n", err);
> drivers/net/ethernet/intel/ice/devlink/devlink.c:1245:          return err;
> --
> drivers/net/ethernet/intel/ice/ice_ptp.c-1935-          dev_err(ice_pf_to_dev(pf), "PTP failed to set time %d\n", err);
> drivers/net/ethernet/intel/ice/ice_ptp.c:1936:          return err;
> --
> drivers/net/ethernet/intel/ice/ice_ptp.c-2000-          dev_err(dev, "PTP failed to adjust time, err %d\n", err);
> drivers/net/ethernet/intel/ice/ice_ptp.c:2001:          return err;
> --
> drivers/net/ethernet/intel/ice/ice_sriov.c-829-         dev_err(dev, "Failed to enable SR-IOV: %d\n", err);
> drivers/net/ethernet/intel/ice/ice_sriov.c:830:         return err;
> --
> drivers/net/ethernet/intel/ice/ice_eswitch_br.c-314-            dev_info(dev, "Bridge port lookup failed (vsi=%u)\n", vsi_idx);
> drivers/net/ethernet/intel/ice/ice_eswitch_br.c:315:            return ERR_PTR(-EINVAL);
> 
Hi, 
Per commit a787e5400a1c("driver core: add device probe log helper"), dev_err_probe was 
originally designed for probe functions in device driver to handle -EPROBE_DEFER.

Using it elsewhere is not the common pattern in the kernel. I'm unsure whether this aligns
with the intended usage if we also address the rest of the sites within the driver.
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index e2fd2dab03e3..31aa42f8e6d3 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -5161,10 +5161,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>>  	struct ice_hw *hw;
>>  	int err;
>>  
>> -	if (pdev->is_virtfn) {
>> -		dev_err(dev, "can't probe a virtual function\n");
>> -		return -EINVAL;
>> -	}
>> +	if (pdev->is_virtfn)
>> +		return dev_err_probe(dev, -EINVAL, "can't probe a virtual function\n");
>>  
>>  	/* when under a kdump kernel initiate a reset before enabling the
>>  	 * device in order to clear out any pending DMA transactions. These
>> @@ -5188,10 +5186,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>>  		return err;
>>  
>>  	err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), dev_driver_string(dev));
>> -	if (err) {
>> -		dev_err(dev, "BAR0 I/O map error %d\n", err);
>> -		return err;
>> -	}
>> +	if (err)
>> +		return dev_err_probe(dev, err, "BAR0 I/O map error %d\n", err);
>>  
>>  	pf = ice_allocate_pf(dev);
>>  	if (!pf)
>> @@ -5202,10 +5198,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>>  
>>  	/* set up for high or low DMA */
>>  	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> -	if (err) {
>> -		dev_err(dev, "DMA configuration failed: 0x%x\n", err);
>> -		return err;
>> -	}
>> +	if (err)
>> +		return dev_err_probe(dev, err, "DMA configuration failed: 0x%x\n", err);
>>  
>>  	pci_set_master(pdev);
>>  	pf->pdev = pdev;
>> @@ -5240,10 +5234,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>>  		return ice_probe_recovery_mode(pf);
>>  
>>  	err = ice_init_hw(hw);
>> -	if (err) {
>> -		dev_err(dev, "ice_init_hw failed: %d\n", err);
>> -		return err;
>> -	}
>> +	if (err)
>> +		return dev_err_probe(dev, err, "ice_init_hw failed: %d\n", err);
>>  
>>  	ice_init_dev_hw(pf);
>>  
>> -- 
>> 2.25.1
>>
>>

