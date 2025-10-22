Return-Path: <netdev+bounces-231706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7CABFCE89
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51243A2DE4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2289320CBA;
	Wed, 22 Oct 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t5Hr/DWY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C227281D
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147257; cv=none; b=sBx/+1fIGo2kztlN55gDQMj/t40XPEbTtl0ZIgH9eBRXXbZpQLMAjT8afQNvL4buon6XblxW5jKqOjKEQqDezoqxCfyt4q2rEgV2l4sun7H3L1x9f3tNszbhjF+e2KPS2tCJk6ec6h7MsOj+0RYf/a7o/j60cdhXscVx5nnqybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147257; c=relaxed/simple;
	bh=PkHPnUsbxZkzek/GiEj83/xA5i75KMMIdaPrV3jIIXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoSN37dMeemGEiECj9+vr1aaupNyhniE4lKnw8+C0C8HFNrR7a4xX5ylKGUw2f4Quzs6oV9cJ9x8tifBna9nPsMO4NsAJBt9s5cYVRRnv96Ph+qroP1vkjVYLUitJXdasVFT7utvsrUDJDkyiNQOtXXig3czytrMXHyJQVtPfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t5Hr/DWY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ig51m017Hcmi9CgavgWY6AP4U9xKzMFKZJ5Epru8aAA=; b=t5Hr/DWYhr1vMSOCdrpLVceSRk
	cLV5xhUcUD3mC7JJr0kTUK0fG20pl6nEUKf/xOiEYWQRVfHGLzB2Lq9eMcqT9UYel+4Gdp7Mz92Ts
	y1N1N5zR+1C+DL9Ub3vGTfhXdmXnJwoGRjpQGKHwx2scfh5CB6bmLBPNQ6oaeShZbibw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBaqq-00BmEB-BY; Wed, 22 Oct 2025 17:34:12 +0200
Date: Wed, 22 Oct 2025 17:34:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Eigner <johannes.eigner@a-eberle.de>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Message-ID: <82ab2f16-b471-4d60-850d-ee4b83712cdc@lunn.ch>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
 <20251021-fix-module-info-json-v1-2-01d61b1973f6@a-eberle.de>
 <0b99a68f-0dd3-4f95-a367-750464ff1fee@lunn.ch>
 <aPjxYbbiYAexF9nQ@PC-LX-JohEi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPjxYbbiYAexF9nQ@PC-LX-JohEi>

On Wed, Oct 22, 2025 at 04:59:45PM +0200, Johannes Eigner wrote:
> Am Wed, Oct 22, 2025 at 03:32:24PM +0200 schrieb Andrew Lunn:
> > On Tue, Oct 21, 2025 at 04:00:13PM +0200, Johannes Eigner wrote:
> > > Append "_thresholds" to the threshold JSON objects to avoid using the
> > > same key which is not allowed in JSON.
> > > The JSON output for SFP transceivers uses the keys "laser_bias_current",
> > > "laser_output_power", "module_temperature" and "module_voltage" for
> > > both the actual value and the threshold values. This leads to invalid
> > > JSON output as keys in a JSON object must be unique.
> > > For QSPI and CMIS the keys "module_temperature" and "module_voltage" are
> > > also used for both the actual value and the threshold values.
> > > 
> > > Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
> > > ---
> > >  sff-common.c | 50 +++++++++++++++++++++++++-------------------------
> > >  1 file changed, 25 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/sff-common.c b/sff-common.c
> > > index 0824dfb..6528f5a 100644
> > > --- a/sff-common.c
> > > +++ b/sff-common.c
> > > @@ -104,39 +104,39 @@ void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
> > >  
> > >  void sff_show_thresholds_json(struct sff_diags sd)
> > >  {
> > > -	open_json_object("laser_bias_current");
> > > -	PRINT_BIAS_JSON("high_alarm_threshold", sd.bias_cur[HALRM]);
> > > -	PRINT_BIAS_JSON("low_alarm_threshold", sd.bias_cur[LALRM]);
> > > -	PRINT_BIAS_JSON("high_warning_threshold", sd.bias_cur[HWARN]);
> > > -	PRINT_BIAS_JSON("low_warning_threshold", sd.bias_cur[LWARN]);
> > > +	open_json_object("laser_bias_current_thresholds");
> > > +	PRINT_BIAS_JSON("high_alarm", sd.bias_cur[HALRM]);
> > > +	PRINT_BIAS_JSON("low_alarm", sd.bias_cur[LALRM]);
> > > +	PRINT_BIAS_JSON("high_warning", sd.bias_cur[HWARN]);
> > > +	PRINT_BIAS_JSON("low_warning", sd.bias_cur[LWARN]);
> > >  	close_json_object();
> > 
> > I'm struggling understanding the changes here. Maybe give an example
> > before and after.
> >
> 
> Shortened example for laser_bias_current, full output at end of mail.
> 
> Shortened output without patch
> $ ethtool -j -m sfp1
>         "laser_bias_current": 15.604,
>         "laser_bias_current_high_alarm": false,
>         "laser_bias_current_low_alarm": false,
>         "laser_bias_current_high_warning": false,
>         "laser_bias_current_low_warning": false,
>         "laser_bias_current": {
>             "high_alarm_threshold": 80,
>             "low_alarm_threshold": 2,
>             "high_warning_threshold": 70,
>             "low_warning_threshold": 3
>         },
> 
> Shortened output after patch
> $ ethtool -j -m sfp1
>         "laser_bias_current": 16.168,
>         "laser_bias_current_high_alarm": false,
>         "laser_bias_current_low_alarm": false,
>         "laser_bias_current_high_warning": false,
>         "laser_bias_current_low_warning": false,
>         "laser_bias_current_threshold": {
>             "high_alarm": 80,
>             "low_alarm": 2,
>             "high_warning": 70,
>             "low_warning": 3
>         },
> 
> > The commit message talks about adding _threshold, but you are also
> > removing _threshold, which is what is confusing me. Is this required?
> > It makes the ABI breakage bigger.
> 
> Removing _threshold from the child objects is not required. I removed
> them because it is somehow redundant to have _threshold at the parent and
> child. If a smaller ABI breakage is more desirable I can drop the
> removal of _threshold in the children.

Thanks, that makes it clearer. Please expand the commit message.

As to ABI breakage, we have to consider, did this never work, so it
does not matter if we change it?

1) Does the first patch suggest it has always been impossible to get
this part of the module dumped in JSON format?

2) Because the JSON is not valid, how do most parsing libraries handle
that? Do they exit with an error, the JSON is invalid? Are they
typically forgiving and just return one of the two values?

If it never worked, we cannot break anything, so an ABI change is
O.K. You need to state that in the commit message. If it might of
worked, we need to be more cautious, and i would minimise the changes,
keep the redundant _threshold, and again, explain this in the commit
message.

	Andrew

