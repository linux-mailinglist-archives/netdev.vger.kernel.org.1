Return-Path: <netdev+bounces-102004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E25990113E
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4699B282DC2
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A9176ABB;
	Sat,  8 Jun 2024 10:10:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491613F440
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717841412; cv=none; b=hCLnimY5OI+qrdYGz/ySltQdWFLPVF0SLr2JzvO+CDhQ2EZ+PJ74WBcudeetxkJSxFNE/4M8gOqv0JfnBmCM/WKY6PtFiPoN5mh52sagEdXYzaaPfWwA8zKaU9VxjaLi+qKmltsdPoFvxGeqrfCmkNRNOJ57iZ/Jh0Gg37GXIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717841412; c=relaxed/simple;
	bh=zEjQS1azbPNeHHqLZVSdQZUshzBYfd7PeRVK65agaM0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqVR1svCNbt/q/IAumkDhezVjMD7CPeEOpKrWzMIR0JezX4BimIc09tSl5rPZhGvSEuvNcOATfd9NpimIZV6EHwNLRWn9iabZyAzeV3DJYajm+2RNn2GzXBNPSzfdmwDqSnMsYVTXK4SnCTqgGMKmeS+7HJ+5E8OCDl2AMeD0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 4888ce27-257f-11ef-80e2-005056bdfda7;
	Sat, 08 Jun 2024 13:10:08 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 13:10:07 +0300
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
Message-ID: <ZmQt_6DaGFXbagSB@surfacebook.localdomain>
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510110405.15115-1-vadim.fedorenko@linux.dev>

Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko kirjoitti:
> The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
> of serial core port device") changed the hierarchy of serial port devices
> and device_find_child_by_name cannot find ttyS* devices because they are
> no longer directly attached. Add some logic to restore symlinks creation
> to the driver for OCP TimeCard.

I know that I'm a bit late to the party, but this patch looks like an ugly
hack. The PTP OCP code, in my opinion, needs a lot of love besides the UART
part.

-- 
With Best Regards,
Andy Shevchenko



