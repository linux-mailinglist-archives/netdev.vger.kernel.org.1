Return-Path: <netdev+bounces-139674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A19B3CB2
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570B6B2209D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08C1E32D3;
	Mon, 28 Oct 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z57Tdnh1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144701E22EF
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150977; cv=none; b=n56dmoEk5GGZSnCjDSwkbJfj3Fngs2KxdesGYu4CglWgS+LjXka2qFZaVYFHs9YcXFFZPG0XACthKNNfCGtZooFUnhsXrsiE7CyGHAEEDgK2fKnEGs3w+fp3R0tEXkSwQ7KOL3jk57k06uDihed6szvLjZG+oZ/d0O2j5+0D5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150977; c=relaxed/simple;
	bh=py37y9z9PRubJz9Idc6Vt0CnDN95HkhBfFA6RTCP5nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdFAYpW7d3gKZfIVGDYFiEOp6hH8vzGP4XlEx99oAH0sieyD3CwUpT4SI1R7FZ9ifAR4cz0RofG1JTNpAFL1IOizqdtaaqDbH+6nOTndG2JZuWQMyr4LC/XWJMAr0g9Nmo/FildgiYzAH91qgP1R5wH3XlzLSgPCFK4EwkQqjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z57Tdnh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59666C4CEC3;
	Mon, 28 Oct 2024 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730150976;
	bh=py37y9z9PRubJz9Idc6Vt0CnDN95HkhBfFA6RTCP5nE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z57Tdnh1LEQWiAv+UWgwEMOT4vyXjjZUtvdIiM11CZIfozjyFOe3Sd6zHvvw+vOXA
	 VBTfp1Oq3fUnC7MuNmIJnwxSflRR3Vxsjp5fK+ejmE58lJrxykuuUyv6ntB5TlRhix
	 QNgK6epvfm850aICfCQTk1CKOEazWjgTgmbE0gsFO1vrOS/8hYwGLumy0Bc1jcRMEe
	 dDH7s5+kDF2Evxstc3tNak96Cb0e2ahkHfwz0gg1ohojbUDnrjByGMTxqiQooYkz+N
	 HDwMWKkzZW1TM/CBBOEcOAmM4TOzTa6N6GpX5R/bxwcbDUjzF6NcPYRilh6inmefvG
	 jCbJ5S1kYmevw==
Message-ID: <845f8156-e7f5-483f-9e07-439808bde7a2@kernel.org>
Date: Mon, 28 Oct 2024 15:29:35 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: yaml gen NL families support in iproute2?
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
 <61184cdf-6afc-4b9b-a3d2-b5f8478e3cbb@kernel.org>
 <ZxbAdVsf5UxbZ6Jp@LQ3V64L9R2>
 <42743fe6-476a-4b88-b6f4-930d048472f9@redhat.com>
 <20241028135852.2f224820@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241028135852.2f224820@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 2:58 PM, Jakub Kicinski wrote:
> I was hoping for iproute2 integration a couple of years ago, but
> David Ahern convinced me that it's not necessary. Apparently he 
> changed his mind now, but I remain convinced that packaging 
> YNL CLI is less effort and will ensure complete coverage with
> no manual steps.

I not recall any comment about it beyond cli.py in its current form is a
total PITA to use as it lacks help and a man page.


