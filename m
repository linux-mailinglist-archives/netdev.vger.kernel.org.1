Return-Path: <netdev+bounces-96155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5878C4822
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C8DB22989
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A8D7E572;
	Mon, 13 May 2024 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MYCeqSv7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BE39FD8;
	Mon, 13 May 2024 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631822; cv=none; b=uVZc2M3uyR5Yd70V/3F3IfAc3zPsiF72HICDLhDzcgAOpVGQr9OY2AQ6KHDp193QCefCQHXdeUml4oQSUsU6rWlQEBARAtLLrN7yCw9DH66dnw41N9Vn/VwO6UlBBYpJfinihpkRoQ1WDn8pUwtOBqOe2dqNniflzLPFbNj/PuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631822; c=relaxed/simple;
	bh=2y6lIR7UUi3HT4p1jrZVxbAYi7+AJOkRG82ari9GLCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdj/+V0cDAT1tnKpX02c97Txy+Abnb55zjsfNUTU9xZLmqlFGwqFSmVlv8lw+1T61RxgZYZeJnfD+NxmHustnO/aWeHFY9NRHiM5mhYtkryzvuam9P8/NTPgniUmNPrFLs0vtl6fTEgdn52RWbfC9rDxWoVto6ighuTJ4MTwS6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MYCeqSv7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KSM9V1vBTjgznXi3QwcS9ZgOCMBEU14RG9Mn0qnphd0=; b=MYCeqSv7+rarJu+j4nANfmy+iI
	km7e3QibYVWSCpz2HMuJ7vh9uxH4jk7fJ3NyMzVum2Cg06tTHsNAfjXFNfokyP+52S/rsnQ4VbYU0
	6Y1Bfbk0r3uVClGNKs8FgbYVXOrFAodGFtOEzdl7PzQA9ib+4t6xSMfqMvrenVpsfXws=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6cCq-00FKlF-Uk; Mon, 13 May 2024 22:23:32 +0200
Date: Mon, 13 May 2024 22:23:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: admiyo@os.amperecomputing.com
Cc: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mctp pcc: Allow PCC Data Type in MCTP resource.
Message-ID: <51bfbccf-9891-4766-a7a7-6b507b3ebc2c@lunn.ch>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240513173546.679061-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513173546.679061-3-admiyo@os.amperecomputing.com>

On Mon, May 13, 2024 at 01:35:45PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Note that this patch sfor code that will be merged
> in via ACPICA changes.  The corresponding patch in ACPCA
> has already merged.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/acpi/acpica/rsaddr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
> index fff48001d7ef..6bd9704f17b0 100644
> --- a/drivers/acpi/acpica/rsaddr.c
> +++ b/drivers/acpi/acpica/rsaddr.c
> @@ -282,7 +282,7 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
>  
>  	/* Validate the Resource Type */
>  
> -	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
> +	if ((address.resource_type > 2) && (address.resource_type < 0xC0) && (address.resource_type != 10)) {
>  		return (FALSE);

More magic numbers. Please add some #defines.

     Andrew

