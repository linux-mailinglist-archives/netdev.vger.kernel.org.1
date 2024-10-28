Return-Path: <netdev+bounces-139672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7D9B3C68
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9CA1C215B1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2371DFE1C;
	Mon, 28 Oct 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abL1gte5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B618FDC2
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730149134; cv=none; b=p9vA9J9A68OOtF12XEHKmgqXqNQIYxbxWVkGjrSHjcv5Eqx8hLkCvBSnpz/gT86fbibcxnWSTawqhG+XeJKQ1o0EJ7JpeZwpjSnRbUYAmWy2yfsU01dI2PuADDi83eSIXDCYp0UodGqhNArON8PoO8dyAQohaRiRqigqcsx5H1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730149134; c=relaxed/simple;
	bh=JmcNmD3sd+Tt1gW/6RyJVqB1gNd192yC4B4dkRCAMmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GuaIbKFbi0/AvAsP8RKcWYQxgSQq/mdOfjWbKK2e/PkXr96Lonom0kA8r4W4S/6/R3dygo/U/1h8zc7SuRZlnhVAIWdX433Y5+SeZXo8JEAkIS85Jj8m44D0JbEAR7YflY1IcG5OL9eCU+0Dhv9R6S4OyxyEhA0O5uCINRE7mX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abL1gte5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C8C4CEC3;
	Mon, 28 Oct 2024 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730149133;
	bh=JmcNmD3sd+Tt1gW/6RyJVqB1gNd192yC4B4dkRCAMmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=abL1gte5PE0QcWlgb4Z1IPmMOla5m2HhM9fHS9bEz0dwVh6kat016KkIZ+ku1fyfT
	 tn9Dx3DEfeQ1a+DjRC3rW5ZjaVlw+P8NX8ctQmI0FvpBcVDxk3dlWzoVERYiZKBTx/
	 MQyrYLgwAJbvxI5UJOVFAnQd9j+UJYJH96bsx+sf+NZ0MqgsG1liW5ImKsGI9inAbB
	 YElWZPUnW1dm/fmCe+FK2uHVHr35p6Qb7xtCrx+qJM4KosU1yBi/cLYHszscdQrULX
	 AYofQjfeLNypMapGMnFcLfcGK56QY8avFDEaLrYD3ilW20CByc6tVEIq8E6jlzllzi
	 6o8BW09a74jBQ==
Date: Mon, 28 Oct 2024 13:58:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>, David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: yaml gen NL families support in iproute2?
Message-ID: <20241028135852.2f224820@kernel.org>
In-Reply-To: <42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
	<61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
	<ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
	<42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 09:55:08 +0200 Paolo Abeni wrote:
> On 10/21/24 22:58, Joe Damato wrote:
> > On Thu, Oct 17, 2024 at 12:36:47PM -0600, David Ahern wrote:  
> >> On 10/17/24 11:41 AM, Paolo Abeni wrote:  
> >>> Hi all,
> >>>
> >>> please allow me to [re?]start this conversation.
> >>>
> >>> I think it would be very useful to bring yaml gennl families support in
> >>> iproute2, so that end-users/admins could consolidated
> >>> administration/setup in a single tool - as opposed to current status
> >>> where something is only doable with iproute2 and something with the
> >>> yml-cli tool bundled in the kernel sources.
> >>> 
> >>> Code wise it could be implemented extending a bit the auto-generated
> >>> code generation to provide even text/argument to NL parsing, so that the
> >>> iproute-specific glue (and maintenance effort) could be minimal.
> >>>
> >>> WDYT?  

Why integrate with legacy tooling? To avoid the Python dependency?

I was hoping for iproute2 integration a couple of years ago, but
David Ahern convinced me that it's not necessary. Apparently he 
changed his mind now, but I remain convinced that packaging 
YNL CLI is less effort and will ensure complete coverage with
no manual steps.

> >> I would like to see the yaml files integrated into iproute2, but I have
> >> not had time to look into doing it.  
> > 
> > I agree with David, but likewise have not had time to look into it.
> > 
> > It would be nice to use one tool instead of a combination of
> > multiple tools, if that were at all possible.  
> 
> FTR I'm investigating the idea of using a tool similar to ynl-gen-rst.py
> and ynl-gen-c.py to generate the man page and the command line parsing
> code to build the NL request and glue libynl.a with an iproute2 like
> interface.
> 
> Currently I'm stuck at my inferior python skills and -ENOTIME, but
> perhaps someone else is interested/willing to step in...

How do your Python skills compare to your RPM skills?
The main change we need in YNL CLI is to "search" the specs in
a "well known location" so that user can specify:

 ynl --family netdev ...

or even:

 ynl-netdev ...

instead of:

 ynl --spec /usr/bla/bla/netdev.yaml

And make ynl in "distro mode" default to --no-schema and
--process-unknown


That's assuming that by

  so that end-users/admins could consolidated administration/setup 
  in a single tool

you mean that you are aiming to create a single tool capable of
handling arbitrary specs. If you want to make the output
and input more "pretty" than just attrs in / attrs out -- then
indeed building on top of libynl.a makes sense.

