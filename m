Return-Path: <netdev+bounces-53205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952708019F5
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60651C20A8E
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B2B5245;
	Sat,  2 Dec 2023 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEDdRSJb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CC17D1;
	Sat,  2 Dec 2023 02:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB36C433C7;
	Sat,  2 Dec 2023 02:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701483307;
	bh=kxY/zxygnE4MHzDkAuR/pnqc4wEOybLOyvU91yMK7W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oEDdRSJbiD4vR+Z+ZG2oa3aQtfHvHTDe7CVSGyxLXd8EUuByoBriA41OhCWIY9LCN
	 7zYgl42L61HiMfAiQTL7vpRCNXv5LCvxODOmArDAGagqFlvKsCwymgjWB3Sz865E/q
	 d7o6w3EGLXxI/Gk5/7KslNiVEsAFrvSFP8msFGof30E7xH1K+J11nMff4+BBNaMJlc
	 VlTp08uKmGgeFU5ppy+Sql7k8YrC8eMhVWRXMU4uOxo/1boQhgpzZZBk0/utuWsAd9
	 VBTBcB7F3VwpDSpwvgfUrZOoPfk8anqbN7aFywD2sI81oPdGlJZ01Xn3XL3K8c8zyE
	 SpsdfsrCzQeqQ==
Date: Fri, 1 Dec 2023 18:15:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 0/6] tools/net/ynl: Add 'sub-message'
 support to ynl
Message-ID: <20231201181505.002edc7f@kernel.org>
In-Reply-To: <20231130214959.27377-1-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 21:49:52 +0000 Donald Hunter wrote:
>  Documentation/netlink/specs/rt_link.yaml |  273 ++-
>  Documentation/netlink/specs/tc.yaml      | 2008 ++++++++++++++++++++++

Should we add sub-messages to tools/net/ynl/ynl-gen-rst.py ?
Does the output look sane with the new attributes?

