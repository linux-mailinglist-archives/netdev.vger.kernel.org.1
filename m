Return-Path: <netdev+bounces-21517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F399F763C68
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3B01C2137A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30AB379A0;
	Wed, 26 Jul 2023 16:27:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B21DA33
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FA6C433C8;
	Wed, 26 Jul 2023 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690388843;
	bh=eFOxHxQyx8SfCvG/xClHU4d5WvCKXehGGtu07AHTx90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tIrlDwOAwbp/hurgiP53gLjSIUi2MeeHJW5+6o6uJnp6Ky2Gd39XmiacMIgyjThEr
	 h/XIVa5t44ClPsL5e5AD/3oMDQzSbLnKM7mvx8DwW6pzj6qYp7iLBgu7SEnsNrKzy1
	 5q6IzJfCVpsT8p48R4APcXM/0J+p8J5OWC9hqcrE1QLq7VMEGGkhLqN2a8SZy+5ITJ
	 SijpFvsvs1GQ9wGTYuirSCpk/7WAR4zfFwo2RAWJ9HAGsjmwN/TS2q7MiP/eeIhpIt
	 M5npFB3YvimJs2e6/ZgvGAciiSX5UAfhoCyA+c0wEa4gMsJXXeKtwMh3pL1z8H60ek
	 c7w4QZmCQO8hQ==
Date: Wed, 26 Jul 2023 09:27:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Asmaa Mnebhi <asmaa@nvidia.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>,
 <maciej.fijalkowski@intel.com>, <olteanv@gmail.com>,
 <davthompson@nvidia.com>
Subject: Re: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Message-ID: <20230726092722.649a15ef@kernel.org>
In-Reply-To: <20230721141956.29842-1-asmaa@nvidia.com>
References: <20230721141956.29842-1-asmaa@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 10:19:56 -0400 Asmaa Mnebhi wrote:
> There is a race condition happening during shutdown due to pending
> napi transactions. Since mlxbf_gige_poll is still running, it tries
> to access a NULL pointer and as a result causes a kernel panic.
> To fix this during shutdown, invoke mlxbf_gige_remove to disable and
> dequeue napi.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

Asmaa, you need to reply to Vladimir, I'm dropping this patch :(
-- 
pw-bot: defer

