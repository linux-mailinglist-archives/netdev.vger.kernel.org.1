Return-Path: <netdev+bounces-229508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE3BDD175
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A626F19C2310
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826B315D5C;
	Wed, 15 Oct 2025 07:22:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F6313E27
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512958; cv=none; b=cu8sZdp/idcLhOK6GyXjUCpfHarOz/SVqJDJ+oSudhQ/puIR0W5JS9xBncuuZ4JfSYFSNsVCh8HBBs22DnCct5f94oVGBhchdKRhzfNqNAuslvtwLD249MXobj6pdFJhzW6BlSAgVaSDIAWpAnDxhf9sRZg8TO8YYR4RwT6sa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512958; c=relaxed/simple;
	bh=w1LfZIAVjLm5WI2OE3Pkuv4PXUTL7V7lh0IXWER6m4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTqIktKKzeSZKDvVzE7AT+x5r5WC/6vI/SiqskEb5flZeGr7yYQeQLv5vb55UBtGjl6/lUxE8hHC4DpPkBZXpgz42yNOtpEcOR3tkttJ5jTb48tHsbxz1fQoLO1B/lzMu++GUFRkPsSvz/KBfssZqX5xRcWXre6cDbIXwzoFpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p57bd968e.dip0.t-ipconnect.de [87.189.150.142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7CE5161E647AB;
	Wed, 15 Oct 2025 09:22:15 +0200 (CEST)
Message-ID: <a49a045c-b01a-48d2-a02c-23540f799f8a@molgen.mpg.de>
Date: Wed, 15 Oct 2025 09:22:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v8 3/9] idpf: move queue
 resources to idpf_q_vec_rsrc structure
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20251013231341.1139603-1-joshua.a.hay@intel.com>
 <20251013231341.1139603-4-joshua.a.hay@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251013231341.1139603-4-joshua.a.hay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Joshua,


Thank you for the patch.

Am 14.10.25 um 01:13 schrieb Joshua Hay:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> Move both TX and RX queue resources to the newly introduced
> idpf_q_vec_rsrc structure.

What is the motivation for doing this?


> While at it, declare the loop iterator in loop and use the correct type.

Please make this a separate commit, as the diff is already big enough.


Kind regards,

Paul


> Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8:
> - rebase on AF_XDP series
> - remove dev param from rx_desc_rel and access through q_vector
> - introduce per queue RSC flag to avoid vport check
> ---
>   drivers/net/ethernet/intel/idpf/idpf.h        |  69 +--
>   .../net/ethernet/intel/idpf/idpf_ethtool.c    |  91 ++--
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    |  71 +--
>   drivers/net/ethernet/intel/idpf/idpf_ptp.c    |  17 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 451 +++++++++---------
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  21 +-
>   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 258 +++++-----
>   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  12 +-
>   drivers/net/ethernet/intel/idpf/xdp.c         |  37 +-
>   drivers/net/ethernet/intel/idpf/xdp.h         |   6 +-
>   drivers/net/ethernet/intel/idpf/xsk.c         |   7 +-
>   11 files changed, 561 insertions(+), 479 deletions(-)

[…]

