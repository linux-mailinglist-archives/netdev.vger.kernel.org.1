Return-Path: <netdev+bounces-109074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC0926CCE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A4AB22CDF
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE94437;
	Thu,  4 Jul 2024 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqm6hD+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D423BB
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054273; cv=none; b=lNeKNZLb8Oqh7AvpMO0VDCG2u6eLl6CuX/dw4lItXtGIG2lVgwrC40Wl9Woq08/S4GDzxFaxm7lg3g7v9QFjQRxkosj2cRXpQLx5lXWgP6CRniAbVspPTMXkezsbpgwElRhC50XZv9tGZpRIBHD9SnpCIdmggd6Uivpl4EvJA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054273; c=relaxed/simple;
	bh=hZEjzzMHg8tXoei8lgSxRu9AZ7ue6cXsBxZ/MAV8AMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DC///KSxs6M10+G3Of7CAkS1EvFkly1mJjRXNtp++Ab7k5zhlejcvuVS339v4VO2JjFvF3lyqYAhXkivro1OhHcR5RTURlttR5Pmv/37zcPymwb1a7O8lziXlgrfZBxWGFrLjtUvpCFi2fZpV25fQne2l6TWBspEKELTgU3KOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqm6hD+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD530C2BD10;
	Thu,  4 Jul 2024 00:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720054272;
	bh=hZEjzzMHg8tXoei8lgSxRu9AZ7ue6cXsBxZ/MAV8AMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqm6hD+tln0xSDaHomsX/Ek5V+WbDP3Vvs5gKKT0/ZrXUDq9LZFvpcDXwO0R5/kcc
	 33MJX2ewUoF7ybN2MHkhQt1663emhELGdZzIti1ZJOIhBpYiN6RQp1UNFTRTM2CTtw
	 S0ypoYFln7aBNi9QPnSH/aWYEY+5346GAy5A/EjzV54ZUMed6b54P91O9dS9VQ062J
	 aW90tG1RGf338oRwYRpc9LHBxqNZKizMjxX/RsM7v+VtOqa+sE1EHV4i+GdYOqdo2j
	 JTBG75O63nZmtAC0/0f5FEm9TFyCZxIkvZHE5M4anyS3mBedjnwATf1BKW8kQ8iME7
	 L0Pwawa5/T8WA==
Date: Wed, 3 Jul 2024 17:51:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [RFC net-next] generate boilerplate impls such as
 devlink_resource_register()
Message-ID: <20240703175111.0832953e@kernel.org>
In-Reply-To: <4886830b-73fe-47f5-9635-0f3910c8e205@intel.com>
References: <4886830b-73fe-47f5-9635-0f3910c8e205@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 12:13:58 +0200 Przemek Kitszel wrote:
> I have and idea that boilerplate devlink_ wrappers over devl_ functions
> could be generated via short script, with the handcrafted .c code as the
> only input. Take for example the following [one line] added to 
> devlink/resource.c would replace the whole definition and kdoc, which 
> would be placed in the generated file in about the same form as the
> current code. This will be applied to all suitable functions of course.

How?

> The script will be short, but not so trivial to write it without prior
> RFC. For those wondering if I don't have better things to do: yes, but
> I have also some awk-time that will not be otherwise spend on more 
> serious stuff anyway :)

What's the exchange rate from awk-time to other types of time?

