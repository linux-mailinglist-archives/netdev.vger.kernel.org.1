Return-Path: <netdev+bounces-292162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA6ANnilFmoOoAcAu9opvQ
	(envelope-from <netdev+bounces-292162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:04:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A385E0CE1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF14830BEE41
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350F83CDBB7;
	Wed, 27 May 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LPEWvyU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KXOWrSH2"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D73CFF42;
	Wed, 27 May 2026 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868606; cv=none; b=UJYH8hHZ8YwFPcp5L0BUaRfebEDKRPiSaSDjPTFhNaZ7WT9in+edIXhrPvGXRq983D6q+0PMzMDjeg65lEnaA5RjQ8QhREx4GeIUDr6ATqT7ZaOYl0RmFlftH/wxs2Eghewtl1n88vSWOF9RE6ana9SfAftN2bXv2+RUqtpR1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868606; c=relaxed/simple;
	bh=VkWEmwKD3t9ZTmY389ZKLUMf5VWzc/cC1v5mWbHzJRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVWqRfAEoykoUSZnftWndKyL90elSV690lImZaT0HSMk1d2zU4h2APxxq5Rwatpc3SIM+dOtFFTWM/LqiHGnl5zrH1KGCYJs4tuqt6XsoaSuEoWHKbGfeBMadVQT6/dcU/zv1WODByO3zOc11LM0nTFpnI2QuSSAKgl16LCZZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LPEWvyU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KXOWrSH2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A332EC0204;
	Wed, 27 May 2026 03:56:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 27 May 2026 03:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779868603; x=1779955003; bh=S9HgsDpIra
	Qs6ELmiQhI4YE1ElINdY7ducPtyqsAzJs=; b=LPEWvyU6IKP6HG/y58TZgEdgGX
	OzvimGQKaFB7zH+4phkALqej/C8T9cWjZtGhLW6tPq6ijaPq0zAscJJEn5RCyfPt
	WeMn6Q6Gxxiy7mn6sPdL53RYlLrj9o7KRBWOyjiNpCrFkvrZhZLjdN7fugJPTznI
	LLLanJuiOIZeHNhOWYEfxy6c++TqlpSn/+X6+BdulM8AK6ie57W7Jyx9cF8zaTHd
	FdUbeM58odwfdR0agh8bmZwU0IWxlzafQSWjf4pQIC5xmppJWFP7+13bf+B5AGLm
	RTewLRlDqZ6YzvnFFBSCEo7nc64yKD8/yqL5bOkM+9eOKf9xg93jEhdB4TvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779868603; x=1779955003; bh=S9HgsDpIraQs6ELmiQhI4YE1ElINdY7ducP
	tyqsAzJs=; b=KXOWrSH2yu5ueAb2ppIceNM9Sj5yKME131hbl2/NrSFzM1XQZut
	TRH8F29e3I0px5LEBYF5f9VWNNMgbWVKEuR3oQJhoOjY1A3fvn38fkXOykXuo09k
	WrvGmHnvq3gPi2f/H5Z/RlNebi4AOHH1D0OH9uBnddnhVCdLLpGTl81CrmvqYKRD
	s/g9+hLYRn02nRK1I+bAVcJ2Tds9kWUHmkJ4SRSULoi6oofQCrA9m9+gorFiw9mh
	CmtMF6up/DB1l1sqEBqjIITKbTWHIELSm8peXSM8edwEH/K3uv3heUqDgZc/f7+u
	jFs7LdRT2WLCWb61S5D+IFf3jRVar9NJPZA==
X-ME-Sender: <xms:uqMWapfbss6hvv6lH8zIyOlSlqt1MPVMECb9Yhk_3RnuhnMpLPQuqA>
    <xme:uqMWavLfmxj_JweXWHuO3EBDM47JfBILK0oV7yD5HNzvWjpIXC4M8RYkiArUo-i4q
    C1_42H2fokez9tynWn1du1ey7SUeMDsauET_pmSgJRO2kzRB4c>
X-ME-Received: <xmr:uqMWapvPT-oYK8fZjko3ZtTwcKPPIVMm78pdmPh4Bfr8uVVpnB9VIKpgzbY>
X-ME-Proxy-Cause: dmFkZTEBUmseUL0dgwnrJDASI2CZc8hGzGSmLPBl3Fk6XbncYeNh6E7Dz6gb6SdCwaA/ao
    QJ0T4+3xQyC+VccLcD4YNamgx+jwUz2vu9HqOlqa1BY6iBwipSSsgV2l6f2mXMEOPOBkhy
    GwBRDCUU9eS1rf1sSubpKeIJA5NxswayFoYK7fl+18m9MC6/HxxXUFXwY2GYP1/0/6caAq
    50a94NgXQpO9Idx896x3215WdL7Pwwxhlkw+aB/xAfar5BxKwd3GDy31EAdObtLM1kM2V0
    vM03yBtuyZzX0BC/f3Ms4twBPvqwP3xOKm86hm3oE8rtdXvBT74Fw1TmWcQJjcXX81vXcl
    sg2zvC4Ru3VkIHwmwYulmqve8tnwGUzeGmxbMoFF1rR4hMom2XJh6qFS9XdPoFXkAnJtzU
    pwVXOsgswpBr6D0uCsljp/9flUgMNIb6WF+Qr3GPwWjbZuDKSX482slY/1/OjSGmMYFGRI
    wUrBe8tfSAPHXqMBWXEgKnYjWMXfADba+Yn+eybsgV8KHL+pEWZ968ptswmqI4Q+TMB6+v
    JDq7fVwuVHf0tAaPcPK9tMJw83CJFtlReLD7y9/3naBfEBVQihdmSmSIjJ69fadhzgO57x
    gx5hgQgaiSWd+kIkynUOj2Rn4jNN8mlmHk5b8fbrc7vrawzqs1nHUht/wrVQ
X-ME-Proxy: <xmx:uqMWapYESFqPNZfoqbcg9mv54GEPYfF3ZByFkw6vW9czv0sgyvX1qw>
    <xmx:uqMWah0KACXUN3mwlmp9V8KSzvPJbRDrIiyz786J_8vipl01vQ419Q>
    <xmx:uqMWanWUjGcy1EhN6J4FnT8Rh9w9KOlY8acr60f9pmuc1gy9vJ8peA>
    <xmx:uqMWaktId9BJe-k6W6wvFfgBEilILOz4T47WfEpGgyNxn6K9BhRXDQ>
    <xmx:u6MWaqhMgYHk34ZYnEt8gP_Ap_ltbXJ2COL9DfYiHYCq-0Hd8QvydPjf>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 03:56:42 -0400 (EDT)
Date: Wed, 27 May 2026 09:55:50 +0200
From: Greg KH <greg@kroah.com>
To: Shaoxu Liu <shaoxul@foxmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add power management op for RNDIS host
Message-ID: <2026052725-femur-spendable-4ff0@gregkh>
References: <tencent_513B1F71D30856A55BAA6CBDB22A5E719508@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_513B1F71D30856A55BAA6CBDB22A5E719508@qq.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292162-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,foxmail.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kroah.com:dkim]
X-Rspamd-Queue-Id: 69A385E0CE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 03:47:41PM +0800, Shaoxu Liu wrote:
> RNDIS host does not manage the USB power, and it will
> cause more power consumption even when no data transferring.
> 
> Adding the power management operator will make the USB
> enter suspend mode when no data transferring.
> ---
>  drivers/net/usb/rndis_host.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
> index 7b3739b29..76eb65fd5 100644
> --- a/drivers/net/usb/rndis_host.c
> +++ b/drivers/net/usb/rndis_host.c
> @@ -630,6 +630,17 @@ static const struct driver_info	zte_rndis_info = {
>  	.tx_fixup =	rndis_tx_fixup,
>  };
>  
> +static const struct driver_info	rndis_info_lowpower = {
> +	.description =	"RNDIS device",
> +	.flags =	FLAG_ETHER | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
> +	.bind =		rndis_bind,
> +	.unbind =	rndis_unbind,
> +	.status =	rndis_status,
> +	.rx_fixup =	rndis_rx_fixup,
> +	.tx_fixup =	rndis_tx_fixup,
> +	.manage_power =	usbnet_manage_power,
> +};
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static const struct usb_device_id	products [] = {
> @@ -657,6 +668,11 @@ static const struct usb_device_id	products [] = {
>  	/* RNDIS is MSFT's un-official variant of CDC ACM */
>  	USB_INTERFACE_INFO(USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
>  	.driver_info = (unsigned long) &rndis_info,
> +}, {
> +	/* RNDIS for Telit Cinterion low power LTE cat1biz modules LE310X1*/
> +	USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x7030,
> +				      USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
> +	.driver_info = (unsigned long)&rndis_info_lowpower,
>  }, {
>  	/* "ActiveSync" is an undocumented variant of RNDIS, used in WM5 */
>  	USB_INTERFACE_INFO(USB_CLASS_MISC, 1, 1),
> -- 
> 2.25.1
> Signed-off-by: Shaoxu Liu <shaoxul@foxmail.com>
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

