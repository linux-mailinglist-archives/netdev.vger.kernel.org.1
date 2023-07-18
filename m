Return-Path: <netdev+bounces-18699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89414758539
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F022816AB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFC3156C8;
	Tue, 18 Jul 2023 18:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB9168A1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157DBC433C7;
	Tue, 18 Jul 2023 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706762;
	bh=XfUR3bmNgBsO2KU4d/1fcEto6Y85MNBj5coGiduXoU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dkuqskzXE9YKa74nfeH/NR/dAjv1VqwlS1rfVXTMwEmvAHO1cF22gL4B8hWvroXsP
	 UHrzjTgsOcS7HLnvJ2TXDZ8Z3O3Eok2A2zlfs5slvbmFPVhoYO7qF5FOdLLPErU++4
	 rWxzPdXS6O7dAcJ81ZP6akY6akWujiOOkU55r6ZA8cqC0pwDfogHyQz9F+TTRRNE0X
	 A5jONEYdPoLqJL23k0fR43IZUguLaZquhNh9nY3QV+0d5bGFVYceDg8EV4zyg2Wi+N
	 t7wmpEzSRUmf6VzVXMn8Nl3BYU3bP5KQMV6LPYrrG8s6MytTu5X/UprAb6ELxczHnR
	 msNjnRjlvjlEQ==
Date: Tue, 18 Jul 2023 11:59:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "open list:NETWORKING [GENERAL]"
 <netdev@vger.kernel.org>
Subject: Re: nvme-tls and TCP window full
Message-ID: <20230718115921.4de52fd6@kernel.org>
In-Reply-To: <a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
	<49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
	<ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
	<a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
	<6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
	<1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
	<9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
	<a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 12:16:13 +0200 Hannes Reinecke wrote:
> >> And my reading seems that the current in-kernel TLS implementation 
> >> assumes TCP as the underlying transport anyway, so no harm done.
> >> Jakub?  
> > 
> > While it is correct that the assumption for tcp only, I think the
> > right thing to do would be to store the original read_sock and call
> > that...  
> 
> Ah, sure. Or that.

Yup, sorry for late reply, read_sock could also be replaced by BPF 
or some other thing, even if it's always TCP "at the bottom".

