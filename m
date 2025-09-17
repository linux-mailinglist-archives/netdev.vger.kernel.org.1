Return-Path: <netdev+bounces-223868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E1B7E818
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1851C03760
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 06:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9767C27B34D;
	Wed, 17 Sep 2025 06:50:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D425EFBE;
	Wed, 17 Sep 2025 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758091851; cv=none; b=feerAJwZVc0u8XMAsDwTKhVPlAt93QF89UaFMx5DkY41mQk69iBFoqMkQ7orpkP8wpBMq9xDzn+pBuh2D+YxXZRqVZyvshntzE3zQaKHYRLB1BPlEH4FpP6N08+MqS7YAev4VFgxpDadrGKghc1cl6/rTWekR3RgzcULj9oJE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758091851; c=relaxed/simple;
	bh=8tluT2i8GW6WhEmoITXfxdorw8zGejI+ZxqHYeHI9gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggFHhX2kivR33O0b/YhtUW4Gq3w8gDS9xlqIZJiC5qScaB0v3m/otZaIbF+tvO9Hd3eGYuyjgPdUEqkXMmGawpj0X4V/jufA4D7Qecg1wQpgGSqAgGubxAMYgBMS9Q1/2lIJnyHF/85RV9cciayMCAGRkInvbszcKmdL58qoSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.205] (p5dc55721.dip0.t-ipconnect.de [93.197.87.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 58A2F60213C82;
	Wed, 17 Sep 2025 08:49:47 +0200 (CEST)
Message-ID: <329bdb90-578b-4fba-97fd-7000baa281e6@molgen.mpg.de>
Date: Wed, 17 Sep 2025 08:49:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] libie: fix string names for AQ
 error codes
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250916-jk-fix-missing-underscore-v1-1-a64be25ec2ac@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250916-jk-fix-missing-underscore-v1-1-a64be25ec2ac@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jacob,


Thank you for your patch.

Am 16.09.25 um 22:09 schrieb Jacob Keller:
> The LIBIE_AQ_STR macro() introduced by commit 5feaa7a07b85 ("libie: add
> adminq helper for converting err to str") is used in order to generate
> strings for printing human readable error codes. Its definition is missing
> the separating underscore ('_') character which makes the resulting strings
> difficult to read. Additionally, the string won't match the source code,
> preventing search tools from working properly.
> 
> Add the missing underscore character, fixing the error string names.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Fixes: 5feaa7a07b85 ("libie: add adminq helper for converting err to str")
> ---
> I found this recently while reviewing the libie code. I believe this
> warrants a net fix because it is both simple, and because users may attempt
> to pass printed error codes into search tools like grep, and will be unable
> to locate the error values without manually adding the missing '_'.

As always, great commit message! Thank you.

> ---
>   drivers/net/ethernet/intel/libie/adminq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/libie/adminq.c b/drivers/net/ethernet/intel/libie/adminq.c
> index 55356548e3f0..7b4ff479e7e5 100644
> --- a/drivers/net/ethernet/intel/libie/adminq.c
> +++ b/drivers/net/ethernet/intel/libie/adminq.c
> @@ -6,7 +6,7 @@
>   
>   static const char * const libie_aq_str_arr[] = {
>   #define LIBIE_AQ_STR(x)					\
> -	[LIBIE_AQ_RC_##x]	= "LIBIE_AQ_RC" #x
> +	[LIBIE_AQ_RC_##x]	= "LIBIE_AQ_RC_" #x
>   	LIBIE_AQ_STR(OK),
>   	LIBIE_AQ_STR(EPERM),
>   	LIBIE_AQ_STR(ENOENT),

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

