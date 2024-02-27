Return-Path: <netdev+bounces-75424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D39869E43
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5752913EF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789F84E1DD;
	Tue, 27 Feb 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ4hzNdZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535674E1CE
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056145; cv=none; b=SYeo5sUpTWZSLYoiomc662rtKgqF2/kuKXBdACIWav2+EFrTObreT2CyyS4CW23uq/LIt2FXvwfmy4BzS0XkvVUkZ88U5dubSTPhWBsOCdDLdN+1eIwlW+CRogPzUCIrBY+iqbMXTpzHXW3VeZYjJPsqP9VNOjNNDsCt5h5HH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056145; c=relaxed/simple;
	bh=4g/t0X+3jGNAsGJ79hc21s0U8CGBtQVMPzX7vOhbjy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSdfexqo2Q+ljCLU3SEYqpwsttPB82SIUarGUBnT1e+RKd3yK+FwrGXAeOl7+r7kGE0XpPm2VdeTF2h/MVhiWDmlfaTO6TrMkz7yar8WzOUpoS2BirXEEiJXzEV9G0zdJdbny+1NdZYuqaXVlVCxyVRAWoQvDxady4zRN9uj7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ4hzNdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79521C43390;
	Tue, 27 Feb 2024 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056144;
	bh=4g/t0X+3jGNAsGJ79hc21s0U8CGBtQVMPzX7vOhbjy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jJ4hzNdZD+L/VOQCUqClk1J9qXdzOpcyStMfIO0rBwH9b/pk2wekdYfQwV7WhRbSC
	 MGSwDPgEttRJMVg6DfjDRg7/+KokmSss70he4MU9jbMq1pH28YnN0Y8kH4/sTqb3Be
	 vpYllZG5Tk98Cenx41QyQWGx1RbmAeoBrORfxUtwD5FvgRHR7MV2Oey7HziUnoHVdK
	 FDlF/ml5tn0+8n7Yv7rPP2ttbSVXcFLX86xnYcKT0nbqfTQEI65VmAegCzc6DHIjTA
	 mX3td0RJW0rQ046nI1uLddSKXQOBPY/7xWAZ16hGU7OrJY3b4bi/53uWNRVjpBI3Gb
	 9NWv9uw7ybuOA==
Date: Tue, 27 Feb 2024 09:49:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [RFC net-next 1/4] doc/netlink: Add batch op definitions to
 netlink-raw schema
Message-ID: <20240227094903.1cbd923b@kernel.org>
In-Reply-To: <m2msrllsgy.fsf@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
	<20240225174619.18990-2-donald.hunter@gmail.com>
	<20240227081109.72536b94@kernel.org>
	<m2zfvlluhz.fsf@gmail.com>
	<20240227091348.412a9424@kernel.org>
	<m2msrllsgy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 17:36:29 +0000 Donald Hunter wrote:
> Yep, I'm probably guilty of trying to put too much into the schema
> again.
> 
> From a library API perspective, it'll need to take a list of tuples,
> e.g. something like this:
> 
> ynl.do_multi([ (method, vals, flags), ... ])

Either that or some form of "start batch", "exec batch".
And any do/dump request in between the two just gets recorded
and executed at the "exec" step.
Not sure what's cleaner from the user perspective.

> As for the CLI, it will likely take a bit of experimentation to find a
> usable balance between args and json payload.

Yeah :( We may need manual walking of the args given not all do's will
have an associated JSON input :(

