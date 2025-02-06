Return-Path: <netdev+bounces-163401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6BA2A295
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD333A0347
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416D1FFC6C;
	Thu,  6 Feb 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC0N7uIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D0156968
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827920; cv=none; b=JUBi/VJK+Sy11T5yD9QkrE3PlZW67h8rhFhus7Wrh+wA7tESNlURehRjDs76Wx/exR9c+oWIhESwf42zyTmrIVIk8BKCIM8ApGUEMnyL/rs0LohM39O7ul3ke4Ox1wtgVK+b9u8uzHXXkoh0qvuKNyz+zu2Q7tvRnrLZdgwk7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827920; c=relaxed/simple;
	bh=BT3Xj2lQU4/CMYnebLcZtcHV78BN7hYLOTmT/oMW4TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsXrNOViYEFTyaie/c+2DA5wpAJaUyTJT2vSfepE5eUthbHsF3vATn2OJaBHsccpSjjNNV4CH9Co9CmiYnKOO54/m91xvGEjYg1itxPkZ5//hgcrGHMVWu9iAZnoFTNE6rN/pMQrXK7rbO08fajs0Y10+7JvQOs/bPacfYh9BcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC0N7uIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D3AC4CEDD;
	Thu,  6 Feb 2025 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738827919;
	bh=BT3Xj2lQU4/CMYnebLcZtcHV78BN7hYLOTmT/oMW4TY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WC0N7uIw+MoNkbJpy9osVf0ANA8n98/2M/PxHW9Yuo9nw1Be2VU8JzRcisxS4jCL2
	 9krjJWqEKx4bBsq8g5ICuZJytWBcUt80us79hoUKtYi9rHCGY6KLnZZhazaFyNZCsi
	 8A3xyjnnCbYL4G2lnXsKK4s0PaT8EHnze8tqOMf+s4v+zD9MwMiE3z8aGeJ6F+raD9
	 /nPskkzWeIkxktA4EFu+lKUW8GASTzb6g3WvVCF4asVGEJGFSbkR0C42DL0MDOj/Ma
	 05sEQIQgvfprusqGkm/uqnBG00rTUC8HPrSnA3DLRslWzzgDMKFBkmCfxiuRLpY+pg
	 8ZZDD/N8gzoKg==
Message-ID: <c66c2aa1-62fd-4da8-b69e-a845ab955851@kernel.org>
Date: Thu, 6 Feb 2025 08:45:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: health.c: fix compilation on gcc 7.5
To: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Konrad Knitter <konrad.knitter@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Nick Desaulniers <nick.desaulniers@gmail.com>
References: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>
 <20250205204546.GM554665@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250205204546.GM554665@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05. 02. 25, 21:45, Simon Horman wrote:
> + Jiri
> 
> On Wed, Feb 05, 2025 at 11:42:12AM +0100, Przemek Kitszel wrote:
>> GCC 7 is not as good as GCC 8+ in telling what is a compile-time const,
>> and thus could be used for static storage. So we could not use variables
>> for that, no matter how much "const" keyword is sprinkled around.
>>
>> Excerpt from the report:
>> My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.
>>
>>    CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
>> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
>>     ice_common_port_solutions, {ice_port_number_label}},
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
>> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
>>     ice_common_port_solutions, {ice_port_number_label}},
>>                                 ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
>> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
>>     "Change or replace the module or cable.", {ice_port_number_label}},
>>                                                ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
>> drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
>>     ice_common_port_solutions, {ice_port_number_label}},
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
>> Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>> I would really like to bump min gcc to 8.5 (RH 8 family),
>> instead of supporting old Ubuntu. However SLES 15 is also stuck with gcc 7.5 :(
>>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Kees Cook <kees@kernel.org>
>> CC: Nick Desaulniers <nick.desaulniers@gmail.com>
> 
> Hi Prezemek,
> 
> I ran into a similar problem not so long ago and I'm wondering if
> the following, based on a suggestion by Jiri Slaby, resolves your
> problem.
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index ea40f7941259..19c3d37aa768 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -25,10 +25,10 @@ struct ice_health_status {
>    * The below lookup requires to be sorted by code.
>    */
>   
> -static const char *const ice_common_port_solutions =
> +static const char ice_common_port_solutions[] =
>   	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
> -static const char *const ice_port_number_label = "Port Number";
> -static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
> +static const char ice_port_number_label[] = "Port Number";
> +static const char ice_update_nvm_solution[] = "Update to the latest NVM image.";

Indeed, no reason to create an (unused) pointer.

And no, don't use macros for strings.

thanks,
-- 
js
suse labs

