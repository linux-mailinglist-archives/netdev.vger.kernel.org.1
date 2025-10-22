Return-Path: <netdev+bounces-231663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA6BFC288
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 953DE3577D5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2B3451DF;
	Wed, 22 Oct 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qIcTmIeG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CD346793
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139949; cv=none; b=UOPZ4dTDv6KhftUi7jGETO72vyyjla4Ym8LOHCj0yv8DABAYPHntsuszNLQqRXlTGLV94yq/xK82uublOz4os5aNKxEkSRt9x1GdGbwFvHvTZ54189p79S+YWiCbmG5fkZy9R4JEi6Oc4MgpDu8enfvhhO0VRPlz+TjMdqWV0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139949; c=relaxed/simple;
	bh=306dqp35qWpcnviLRe5DARQkqwiKp3BXoOMXCYX7OcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot3zyuW+pFaySW92T/bbTEZZQms397XQLaxalsLdtEEkWXzCZf5k1UXDd1OMNAMQiqYSEcd9048ysDRSepBt7IjQrWYnwcoWiJeP6Ml3CaQdQZ0kqRCK2TVssNOlqR1RKkmUGVir35t+80siaEvwEIG1qvftHXlN9ckROlw30tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qIcTmIeG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WoenqjDJ1G6+Lm7z6ofiZs1xOpqM3wyiiISUP5kXnpk=; b=qIcTmIeGayI5HiMPQ8xzRxycDk
	CZgRXZNqJ111UqzdzMQRrthOq5+HgpchcL9iOC9l2wI5A21TqiVmuWtehZXyzS4Odx/+TC9Wyj858
	hNHoMVzsxEi0lQBLRRvW7wdRSs36fE4xMr4XFGxgBJ2z3TtHnrXqv/yJ9uYoIFvDnv8c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBYwy-00BlP4-C2; Wed, 22 Oct 2025 15:32:24 +0200
Date: Wed, 22 Oct 2025 15:32:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Eigner <johannes.eigner@a-eberle.de>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Message-ID: <0b99a68f-0dd3-4f95-a367-750464ff1fee@lunn.ch>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
 <20251021-fix-module-info-json-v1-2-01d61b1973f6@a-eberle.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-fix-module-info-json-v1-2-01d61b1973f6@a-eberle.de>

On Tue, Oct 21, 2025 at 04:00:13PM +0200, Johannes Eigner wrote:
> Append "_thresholds" to the threshold JSON objects to avoid using the
> same key which is not allowed in JSON.
> The JSON output for SFP transceivers uses the keys "laser_bias_current",
> "laser_output_power", "module_temperature" and "module_voltage" for
> both the actual value and the threshold values. This leads to invalid
> JSON output as keys in a JSON object must be unique.
> For QSPI and CMIS the keys "module_temperature" and "module_voltage" are
> also used for both the actual value and the threshold values.
> 
> Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
> ---
>  sff-common.c | 50 +++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/sff-common.c b/sff-common.c
> index 0824dfb..6528f5a 100644
> --- a/sff-common.c
> +++ b/sff-common.c
> @@ -104,39 +104,39 @@ void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
>  
>  void sff_show_thresholds_json(struct sff_diags sd)
>  {
> -	open_json_object("laser_bias_current");
> -	PRINT_BIAS_JSON("high_alarm_threshold", sd.bias_cur[HALRM]);
> -	PRINT_BIAS_JSON("low_alarm_threshold", sd.bias_cur[LALRM]);
> -	PRINT_BIAS_JSON("high_warning_threshold", sd.bias_cur[HWARN]);
> -	PRINT_BIAS_JSON("low_warning_threshold", sd.bias_cur[LWARN]);
> +	open_json_object("laser_bias_current_thresholds");
> +	PRINT_BIAS_JSON("high_alarm", sd.bias_cur[HALRM]);
> +	PRINT_BIAS_JSON("low_alarm", sd.bias_cur[LALRM]);
> +	PRINT_BIAS_JSON("high_warning", sd.bias_cur[HWARN]);
> +	PRINT_BIAS_JSON("low_warning", sd.bias_cur[LWARN]);
>  	close_json_object();

I'm struggling understanding the changes here. Maybe give an example
before and after.

The commit message talks about adding _threshold, but you are also
removing _threshold, which is what is confusing me. Is this required?
It makes the ABI breakage bigger.

	Andrew

