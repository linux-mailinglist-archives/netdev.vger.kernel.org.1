Return-Path: <netdev+bounces-97841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59B8CD758
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DD61F21128
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669331170F;
	Thu, 23 May 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQkXh993"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70C107A8;
	Thu, 23 May 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478785; cv=none; b=p+JnV7bFZoVXIB5w/+jQxdgj4VR2IPgWzaqVjug7uKcCPEmFgJFq+qcVyKx+WnVmLMebFOCLUrF0oe8Y3r2iFUZOde5F8F0NuEOIMF/QBkUA9fv6TG0D+Y97pyQyqE/rPv1An3tgZqC6oiCI0PNA+G4LOHaxJW179DzbHK0tA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478785; c=relaxed/simple;
	bh=clvydRDm/63x4impppU2AwpkDHe7T/Btp/JH1hYc6t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eh7QqHJpXv+3VNBDrg8u1FZ4tyvzI9NL/eLpLMJ5see2M+8k3W/NUSdlAQxZbVUyJqP9y/GU9ON3gGISrUhy7K+AnCb26bwnv9/5XA5Mk5u91H5/NpQwj1BRn6H/vPXDO0wFDS9jnmrdjBIHSIkWcOt3QwI4UIcLrk9QJnMyQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQkXh993; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43417C4AF0A;
	Thu, 23 May 2024 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716478784;
	bh=clvydRDm/63x4impppU2AwpkDHe7T/Btp/JH1hYc6t8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HQkXh993tlC0PovOExg8HJKVu0BEAR/d2p2/AyntoasSUTkaxiymc1d7Tn6kJJ5N7
	 5JRk2YKzqGxjfv4J8b+rkXiPXdqziBdb/XnfUuDZ+SOTfvrZE9SEOsMIl5UqDLU3PN
	 7NaeIhEaFpo4BCsnHH8o8z1tj/csyvUMY45U8m5oiPxWYN+oQOsceoENXIM8J/iQBt
	 CiqjwzFLOHeqmJ23Q1SHx2RTKi7PlyoX/t5wcyzAy/ISnVCOYO5cCmae5i+oSpHsSn
	 D2iInNqpp4kJmnfNOqw117AsudIt2VcXnEzaaQRBia1GHcd7hf9jw55HxH6gK7GGOH
	 jSClC7gvRRpEw==
Date: Thu, 23 May 2024 08:39:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <20240523083943.6ecb60d9@kernel.org>
In-Reply-To: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 11:04:05 +0000 Vadim Fedorenko wrote:
> The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> of serial core port device") changed the hierarchy of serial port devices
> and device_find_child_by_name cannot find ttyS* devices because they are
> no longer directly attached. Add some logic to restore symlinks creation
> to the driver for OCP TimeCard.
> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> v2:
>  add serial/8250 maintainers
> ---
>  drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index ee2ced88ab34..50b7cb9db3be 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -25,6 +25,8 @@
>  #include <linux/crc16.h>
>  #include <linux/dpll.h>
>  
> +#include "../tty/serial/8250/8250.h"

Hi Greg, Jiri, does this look reasonable to you?
The cross tree include raises an obvious red flag.

Should serial / u8250 provide a more official API?
Can we use device_for_each_child() to deal with the extra
layer in the hierarchy?

>  #define PCI_VENDOR_ID_FACEBOOK			0x1d9b
>  #define PCI_DEVICE_ID_FACEBOOK_TIMECARD		0x0400
>  
> @@ -4330,11 +4332,9 @@ ptp_ocp_symlink(struct ptp_ocp *bp, struct device *child, const char *link)
>  }
>  
>  static void
> -ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
> +ptp_ocp_link_child(struct ptp_ocp *bp, struct device *dev, const char *name, const char *link)
>  {
> -	struct device *dev, *child;
> -
> -	dev = &bp->pdev->dev;
> +	struct device *child;
>  
>  	child = device_find_child_by_name(dev, name);
>  	if (!child) {
> @@ -4349,27 +4349,39 @@ ptp_ocp_link_child(struct ptp_ocp *bp, const char *name, const char *link)
>  static int
>  ptp_ocp_complete(struct ptp_ocp *bp)
>  {
> +	struct device *dev, *port_dev;
> +	struct uart_8250_port *port;
>  	struct pps_device *pps;
>  	char buf[32];
>  
> +	dev = &bp->pdev->dev;
> +
>  	if (bp->gnss_port.line != -1) {
> +		port = serial8250_get_port(bp->gnss_port.line);
> +		port_dev = (struct device *)port->port.port_dev;
>  		sprintf(buf, "ttyS%d", bp->gnss_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyGNSS");
> +		ptp_ocp_link_child(bp, port_dev, buf, "ttyGNSS");
>  	}
>  	if (bp->gnss2_port.line != -1) {
> +		port = serial8250_get_port(bp->gnss2_port.line);
> +		port_dev = (struct device *)port->port.port_dev;
>  		sprintf(buf, "ttyS%d", bp->gnss2_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyGNSS2");
> +		ptp_ocp_link_child(bp, port_dev, buf, "ttyGNSS2");
>  	}
>  	if (bp->mac_port.line != -1) {
> +		port = serial8250_get_port(bp->mac_port.line);
> +		port_dev = (struct device *)port->port.port_dev;
>  		sprintf(buf, "ttyS%d", bp->mac_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyMAC");
> +		ptp_ocp_link_child(bp, port_dev, buf, "ttyMAC");
>  	}
>  	if (bp->nmea_port.line != -1) {
> +		port = serial8250_get_port(bp->nmea_port.line);
> +		port_dev = (struct device *)port->port.port_dev;
>  		sprintf(buf, "ttyS%d", bp->nmea_port.line);
> -		ptp_ocp_link_child(bp, buf, "ttyNMEA");
> +		ptp_ocp_link_child(bp, port_dev, buf, "ttyNMEA");
>  	}
>  	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
> -	ptp_ocp_link_child(bp, buf, "ptp");
> +	ptp_ocp_link_child(bp, dev, buf, "ptp");
>  
>  	pps = pps_lookup_dev(bp->ptp);
>  	if (pps)


