Return-Path: <netdev+bounces-39769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A067C46D5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DC31C20D3B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E9C7F9;
	Wed, 11 Oct 2023 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryjEudkJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC85388;
	Wed, 11 Oct 2023 00:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC9C433C7;
	Wed, 11 Oct 2023 00:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696985253;
	bh=GML/tjgAq13M4+96lhLvoGtPl4yhrUdZshloPeDdWqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ryjEudkJcuUfG9yZePCjX40V0FqAFEM5mudN5TtbVVdwCNZM7Zb3feRbDMR9cUeK2
	 j3JWZN1mGsjcmDty1myc9gr/NchebGTRsncb1SHyXdCF55oSmZsux8VETkAEb+SvXK
	 bp8UmQI/amPTbQ6zfWyumJgv7PQiW+a1CI1Iy7ClAflXAC5SX7duC1fErtPQnB9/bQ
	 m8yOoVyNO8dTv36WGZ+ECuHhJTAqaJ8B3I2OSFIuRNgTUoG51sIIzUn6gNBZ8xojjr
	 bWBJqQ1raQpgyxM311FIJfki/PYhBtcrLJB2AfSzd+OmcaduwanDfvLFhVefPdjUmS
	 cUFPvdMhA5oAg==
Date: Tue, 10 Oct 2023 17:47:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <keescook@chromium.org>
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
Message-ID: <20231010174731.3a1d454e@kernel.org>
In-Reply-To: <CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
	<5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
	<CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 14:41:10 -0700 Justin Stitt wrote:
> > Thanks Justin for these patches, please make sure you mark the subject
> > line as per the netdev rules:
> > [PATCH net-next v1] etc etc  
> 
> Sure, I'll resend!

Please do read the netdev rules Jesse pointed you at.
Maybe it's the combined flow of strncpy and __counted_by patches
but managing the state of the "hardening" patches is getting 
a bit tedious :(

Please group them into reasonable series. Do not repost withing 24h.
Do not have more than 15 patches for networking pending at any given
time. That's basically the gist of our "good citizen" rules.

