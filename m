Return-Path: <netdev+bounces-220780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FBB489FE
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F337A61BA
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDA62F3621;
	Mon,  8 Sep 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3hohKuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83642EB848
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326863; cv=none; b=HoJUs2t5WqQ4fkO8FyUEgZvIBLtsNTK43FFRtdAasHvRNPJ9buTFfsyl8/fxb5Hx/OIVCrvIqEpbbwocS7lmZyvoKQvn9O+wtp74qyU1hyNP+rccDF47xJtYScS5TZRhhapk+USZVoVYu9dfMQ3HYz49qgY/wBvK7Zz+FWIOfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326863; c=relaxed/simple;
	bh=ZKg17N3KraCewQC0K64+ibWjBGkWF7poTE88VMhOUCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvrh1PrlI0W3J7txUAFIR1OPx1kYTj0Ub0R3jO8N6k40jiU9BQ4Hyw49CJaBFNXGzsGj07IoB5UaXWaTMHiXepsQZv1XtDMBZue6D7CyAghM9rqLo6UuBtY0E/aHgsdwqbZ42fAHWCbx+btmw0QqdCSYo6Oq9lwd0wraAx5PSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3hohKuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2E8C4CEF1;
	Mon,  8 Sep 2025 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757326863;
	bh=ZKg17N3KraCewQC0K64+ibWjBGkWF7poTE88VMhOUCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3hohKuTcjAP4oK5h4/WMQSHPPVS/IQ5ybIIwlSiP7kCt0OflRmlg6cgzmz7FK+W3
	 ou8Rubj2+4ojkx2yo3Lh2RvYsEk9frJ6OLF1uYJ/uk8bQxH96EGTgYYjlUCMCCOQSv
	 KxcmDEdKfa1dNK6xO5WWvH6Z+vHvE0SuJ0zKoZZNdjaPxnc0iPKCLiHUpz9k7N5z9F
	 GocYiLVLFrNzI9WVbyX+Fa/BPomP+Br2mrP6AiTFISQKapBagfi6eo59bvfMeXCz0b
	 2VI5wLEPvMh9FkUZuBgdmxoxemyFnIlmMZbcMpPo3u7DRJQ2skIXnHt7upCSzdvfBZ
	 DOR8p12xKFSRQ==
Date: Mon, 8 Sep 2025 11:20:59 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgbe: fix typo in function
 comment for ixgbe_get_num_per_func()
Message-ID: <20250908102059.GD2015@horms.kernel.org>
References: <20250905163353.3031910-1-alok.a.tiwari@oracle.com>
 <IA3PR11MB8986397B4B9F900B6EA39A8FE503A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986397B4B9F900B6EA39A8FE503A@IA3PR11MB8986.namprd11.prod.outlook.com>

On Fri, Sep 05, 2025 at 07:52:13PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Alok Tiwari
> > Sent: Friday, September 5, 2025 6:34 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org
> > Cc: alok.a.tiwari@oracle.com
> > Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: fix typo in
> > function comment for ixgbe_get_num_per_func()
> > 
> > Correct a typo in the comment where "PH" was used instead of "PF".
> > The function returns the number of resources per PF or 0 if no PFs are
> > available.
> > 
> > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Hi Aleksandr,

Perhaps I need more coffee.
But it's unclear to me why you responded to the above with the patch below.

> From: Qiang Liu <liuqiang@kylinos.cn>
> 
> After obtaining the register value via raw_desc,
> redundant self-assignment operations can be removed.
> 
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index bfeef5b0b99d..6efedf04a963 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -143,18 +143,14 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
>  
>  	/* Read sync Admin Command response */
>  	if ((hicr & IXGBE_PF_HICR_SV)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
> -			raw_desc[i] = raw_desc[i];
> -		}
>  	}
>  
>  	/* Read async Admin Command response */
>  	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
> -		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
> +		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
>  			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
> -			raw_desc[i] = raw_desc[i];
> -		}
>  	}
>  
>  	/* Handle timeout and invalid state of HICR register */
> -- 
> 2.43.0

...

