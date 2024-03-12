Return-Path: <netdev+bounces-79511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE51879988
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 18:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04281C21C70
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B7137C36;
	Tue, 12 Mar 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8jfK6Qz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1D137937
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262867; cv=none; b=fiSpLOMcWIPMFxKoNwf2t229+LAR8aztK2rPOk1orSYYCxRUhVhSrsiVrCSwWDoLSVexjpHixYj7DE16bwOft6pccJRvyFsRStx3hpSQqOqheLD7LpNB4DGJYrbrZz8mTaLhQ77g/mUvKLQGOyAXsTaU65KmwTQr9n6lPYh60PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262867; c=relaxed/simple;
	bh=LFEAlJYiHP9dghkatG9KVTKAC4gwYZAElDPm6lw9PQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDXoDrBNTrD15ibzkZbnLFk6/fhaL6dimh83DtIk6unTTFGiP7hK39ao5nOa5Zhn2eTc0XWdj05bul5ZktBWd/EyJxB2gP8XREl0WPy7Zo+gVfjaJPuL0V2RuRdZq6LsT5cQT+9dCkilHT15KvDN2/QnoTcUIXDZCs+KD4Y/0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8jfK6Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656ACC433C7;
	Tue, 12 Mar 2024 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710262866;
	bh=LFEAlJYiHP9dghkatG9KVTKAC4gwYZAElDPm6lw9PQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8jfK6Qzh6gFf0caDzM5bC70pNDpXQJNbFdJ2JwKR6xILLXS4okAemhwtc47K7i7r
	 jkIR7kYXo8WmpX0/bCepykkFwzfaZorDvutHQ4Lr9wkkLQj5tfFzA+fu4gdwEzCS+O
	 UBtdHQEhifAEkm0jBOA8B6woMVutVh1wI0oTB3HFFi7NYp6NbOZqAjDIl4oOsmJYsx
	 AnE33wWIlkjGkV91ogHGmxmEUoFoU7sZpcotHQCZTybvae66dO5hKWLG5ZpgWfMMm3
	 89WBilyxu/XguXBONd+Pl2MGo/eXYDSCwyCYZ6sEK7m/fRcdBbVAiIYzoRnGYo3Bjt
	 AJBGQ5XMqnNZw==
Date: Tue, 12 Mar 2024 10:01:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Subject: Re: How to display IPv4 array?
Message-ID: <20240312100105.16a59086@kernel.org>
In-Reply-To: <CAD4GDZwxS1Av6XNkKnC-pmOWTwuc_u7JRLRkCXO5kJyy6wvwkA@mail.gmail.com>
References: <ZfApoTpVaiaoH1F0@Laptop-X1>
	<ZfBGrqVYRz6ZRmT-@nanopsycho>
	<CAD4GDZwxS1Av6XNkKnC-pmOWTwuc_u7JRLRkCXO5kJyy6wvwkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 16:04:56 +0000 Donald Hunter wrote:
> > "nested-array" would tell the parser to expect a nest that has attr
> > type of value of array index, "type" is the same for all array members.
> > The output will be the same as in case of "multi-attr", array index
> > ignored (I don't see what it would be good for to the user).  
> 
> I'd say that this construct looks more like nest-type-value

type-value is sort of a decomposed array, if we have all the entries
under one nest I reckon array extension may be more appropriate.

My gut feeling is that we should generalize the array-nest type,
when I wrote the initial spec we didn't have sub-type. How about
we replace array-nest with indexed-array (good name TBD), and instead
of assuming the value is always a nest pass the type via sub-type?

For bonding probably something like:

  -
    name: linkinfo-bond-attrs
    name-prefix: ifla-bond-
    attributes:
      -
        name: arp-ip-target
        type: indexed-array
        sub-type: u32
	byte-order: big-endian

how does that sound?

exiting array-nests would change from:

 -
   name: bla
   type: array-nest
   nested-attributes: bla-attrs

to

 -
   name: bla
   type: indexed-array
   sub-type: nest
   nested-attributes: bla-attrs

But that'd mean updating all existing specs and codegen.

