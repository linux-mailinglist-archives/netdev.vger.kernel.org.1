Return-Path: <netdev+bounces-111469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26595931359
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC141F21BB5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6690189F5F;
	Mon, 15 Jul 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILdj5cd/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6B6A039;
	Mon, 15 Jul 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044073; cv=none; b=OXMgLce6w6SDatL0uZAc0/KPdbBWPDmOErlNMzKjqsghZVi7Y5sR2ZtgE0FxlLUFoluvRMD4EhzaBfXxqguZUt43FydNK3qCnGesdQIoK909dZFG/7V8yhD2pyDx8ZJE9giLA5Olrrnbb59MfIW4Mdh8wrQV0NI1Zrkj4/ORVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044073; c=relaxed/simple;
	bh=4BJo//tc2v22Fs1ixcCdXbqWuUgaLKomR+gawoPWb8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq1Xhln4c7Zf5yuqx8AuAieYUJgutWhBouj/ZJs782zuwalu+Srie8V4a5DlKsj5kxcjpmvLXe+EZiLxq2itVLqqRTiDr0RXGILp+5WhijoTt01gTuUOy3WVgSKupYG5GV+IDhr9kYq/waAn7JS/UJhniXudsvrta+UTKSHmuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILdj5cd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A950C32782;
	Mon, 15 Jul 2024 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721044073;
	bh=4BJo//tc2v22Fs1ixcCdXbqWuUgaLKomR+gawoPWb8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILdj5cd/Vuh62Xu+MNpUJKLfYfB4yG9ZKwb8MeVtpNwbwIFGHEs/EzLXuSnqq1IRu
	 Sw+bMkYB1647O+02bj+Eyr1VwsgcNCf7wGvII1ugUC3XiTXtPC1474yzGkv5agl1Do
	 H0iNYGkbKyVb6fwsN0Uokct4w/jqZJLksqySZr40=
Date: Mon, 15 Jul 2024 13:47:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ashwin Kamat <ashwin.kamat@broadcom.com>, linux-kernel@vger.kernel.org,
	davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
	kuba@kernel.org, netdev@vger.kernel.org, ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com, tapas.kundu@broadcom.com
Subject: Re: [PATCH v5.10 0/2] Fix for CVE-2024-36901
Message-ID: <2024071544-helper-bounce-9537@gregkh>
References: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
 <eee4d558-51d5-4f84-8bc8-d01178f5a1e5@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eee4d558-51d5-4f84-8bc8-d01178f5a1e5@broadcom.com>

On Fri, Jul 12, 2024 at 02:19:37PM -0700, Florian Fainelli wrote:
> On 7/9/24 03:22, Ashwin Kamat wrote:
> > From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
> > 
> > net/ipv6: annotate data-races around cnf.disable_ipv6
> >         disable_ipv6 is read locklessly, add appropriate READ_ONCE() and WRITE_ONCE() annotations.
> > 
> > net/ipv6: prevent NULL dereference in ip6_output()
> >         Fix for CVE-2024-36901
> > 
> > Ashwin Dayanand Kamat (2):
> >         net/ipv6: annotate data-races around cnf.disable_ipv6
> >         net/ipv6: prevent NULL dereference in ip6_output()
> 
> LGTM

All now queued up, thanks.

greg k-h

