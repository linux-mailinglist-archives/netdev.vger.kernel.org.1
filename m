Return-Path: <netdev+bounces-243141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E0C99F18
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 04:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0C364E112B
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 03:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C2255F52;
	Tue,  2 Dec 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ofhb9bu1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C1125A0
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764644970; cv=none; b=OCExf5uIrh/JIKQWeNmzORLT02OYMuh1WY4S977+AkLbE+DCbIYZeUvZN+QyljmbTRh8dWg3KqG6AHmhDd/4jlDvl5xgBH67foCdoHGzsEIm/6ltqR8FYFPObqlDbVtWec+89xjvzXQvXhEa+ZwGdIFD1NBf7HIYDLBI7nAXRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764644970; c=relaxed/simple;
	bh=5OlOB/+pAC7GWVFCUMRW5iqzlBr26vjr1v9vu51Js3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHVfgIE6n/mJwrNazGLgQuAFszXFS410MSmMzJSprdtCeOo2lJ5QRXsX31gsKAoK0tP/DoUUDQzvYsgONX/s5Qq6CbwBAWH5cmOirsHGyTlwHljtYA7r01w6gRPJtoh0Pi9R1kG4rkMHCH9PvFU6xDC23KBi9X/oT2bTskvpQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ofhb9bu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA63CC4CEF1;
	Tue,  2 Dec 2025 03:09:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ofhb9bu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764644967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIUpixDVB0GoMeYR1tHmA7gRunJT6iUUET9u9J+jeuE=;
	b=ofhb9bu1YX4bB09WX7NKhDtqVxF8GfZ+DyFBn2mZGSuOvXSqnqc+AADZxpZxPyp8NCnV8k
	7LW80m7p/KJaHzDFD+l9+lkVlOmFUQMJ1bYxfGbLUPqvNPzNA04jc9jiewvHoH0nronKgS
	UsNKMs6iBtGni+GLMD61N+e/7IqO7fc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 86f89715 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 03:09:26 +0000 (UTC)
Date: Tue, 2 Dec 2025 04:09:30 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 10/11] tools: ynl: add sample for wireguard
Message-ID: <aS5Yarah6ZhyckEz@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
 <20251201022849.418666-11-Jason@zx2c4.com>
 <21cf5582-61b7-469b-a235-3d44be898e7e@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21cf5582-61b7-469b-a235-3d44be898e7e@fiberby.net>

On Mon, Dec 01, 2025 at 09:00:41PM +0000, Asbjørn Sloth Tønnesen wrote:
> On 12/1/25 2:28 AM, Jason A. Donenfeld wrote:
> > [..]
> > +
> > +	req = wireguard_get_device_req_alloc();
> > +	build_request(req, argv[1]);
> > +
> > +	ys = ynl_sock_create(&ynl_wireguard_family, NULL);
> > +	if (!ys)
> > +		return 2;
> 
> I will send a patch for fixing up the error patch here, and call
> wireguard_get_device_req_free() before returning here, after rc1.
> 
> The broken error path here was pointed out by the AI reviewer.

Let's just drop this patch 10/11 then from the queue, but merge the
others.

Jason

