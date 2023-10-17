Return-Path: <netdev+bounces-41811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C530D7CBF17
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F9B20EDE
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14C3FB0B;
	Tue, 17 Oct 2023 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYvR6p3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D5381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71240C433C8;
	Tue, 17 Oct 2023 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697534821;
	bh=lcpMF6/W6guREpbGPQFR9XdgG3AcqITe3XAYywvDXHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYvR6p3qmSBMAp6/Qlx67EsX82NfgXT1wMmMazSCqbL8wJ0rPXFw35EltCVYKowVJ
	 VWlM/Zm+MTDEMw/3CywASRQjFLmQPLwrn6qXiivqplxkttG0rrCsE6eusf/8lxkh4h
	 FJERw+cnea46OG3+V6yPCiHWUSgxdslsjaSOm16r90u/wpXpu/5nGC221MCMQ+D4cQ
	 wT7y+femjZB83W/c5G7ueTsXC1mkBjxqYCBkcPOAlCzphOBnt0WaS5UqSiqoX/tFod
	 T4D7Wz7IKUpgwGnaB0815PLDSUuqC+7PwXoW6koDoPypR44jYPiyduBgUC0xcifICr
	 xi2lAtDzMs5mg==
Date: Tue, 17 Oct 2023 11:26:56 +0200
From: Simon Horman <horms@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, aelior@marvell.com,
	manishc@marvell.com, vladimir.oltean@nxp.com, jdamato@fastly.com,
	pawel.chmielewski@intel.com, edumazet@google.com,
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
	d-tatianin@yandex-team.ru, pabeni@redhat.com, davem@davemloft.net,
	jiri@resnulli.us, Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v5 3/3] ice: Refactor finding advertised link
 speed
Message-ID: <20231017092656.GV1751252@kernel.org>
References: <20231015234304.2633-1-paul.greenwalt@intel.com>
 <20231015234304.2633-4-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015234304.2633-4-paul.greenwalt@intel.com>

On Sun, Oct 15, 2023 at 07:43:04PM -0400, Paul Greenwalt wrote:
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
> 
> Refactor ice_get_link_ksettings to using forced speed to link modes
> mapping.
> 
> Suggested-by : Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


