Return-Path: <netdev+bounces-53180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB68019A5
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC9DB20F70
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 01:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A715A6;
	Sat,  2 Dec 2023 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZjpm5FL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0291EC3;
	Sat,  2 Dec 2023 01:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5246C433C9;
	Sat,  2 Dec 2023 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701481623;
	bh=zHoXuze/tHgSV0I63Me1rwYwBOrYEuiWVeI3wye3Vwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZjpm5FL+sBgBmpojD6jcOIcfdVgQsy/iMhT485FVITP9epvRb3S+Xe6EW7Nw0HHS
	 SBlMOmb7ktzYcYUnuOrELrmHgj+bPf4EPlYA16Ziej1P2sFRwiURUYBJOcOsBDdwgF
	 8EwiN//7F+cc1A5QeesIu0TKxGG/KFDlCTUDaQEuYf8aAVFAKCP0NpBWhhWFjQWrnn
	 vUuAqevI2pZ8eMHPTPnHdpfKZxDG/NgbsF4r8/arrOkK8vgJOUr/AlomyHs8EujTUK
	 DYKwLANs7y+ND6Pg2l3fXaLt8/3k/tRcGr1MWgKWOq8sMWMcCjrOWU+p/2lGN59xWo
	 pav3vCfJol3Tg==
Date: Fri, 1 Dec 2023 17:47:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 1/6] doc/netlink: Add bitfield32, s8, s16 to
 the netlink-raw schema
Message-ID: <20231201174701.16ccb0ae@kernel.org>
In-Reply-To: <20231130214959.27377-2-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 21:49:53 +0000 Donald Hunter wrote:
> The netlink-raw schema was not updated when bitfield32 was added
> to the genetlink-legacy schema. It is needed for rtnetlink families.
> 
> s8 and s16 were also missing.

Let me apply this one already, it's kinda independent.

