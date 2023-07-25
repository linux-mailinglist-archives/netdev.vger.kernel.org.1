Return-Path: <netdev+bounces-21098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B09762741
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D342A1C20F46
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF3275CA;
	Tue, 25 Jul 2023 23:22:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8468BE1
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363D4C433C8;
	Tue, 25 Jul 2023 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690327356;
	bh=PBIqA5Gq9VSHmBnlqk5US6T3Jk+lxP+vzcT70wsMidw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oovSboVRAaF4hYnGrnhk7S8ASbcN548mleKrBIldUFVvQ65CGuXMOSWqPajbtONyr
	 Lndri4dQDQin0L0V/ypqyG5kWYcpFB0STaAz27809RHp4Ebl9834BWI/9dQBuXUM/6
	 fUNS3HvU/1qQhu+Vt/sw9xE8mAPFRAG5F5QwhBk+uUxXdJKLz/rt9BEWI3cgHvlzOo
	 IvDtFytLzTk/1ITYudSIzoRafhUOJxxyoN/SFUy4rUezVE0dbPNSYNz4i5XAaHOJaU
	 AedgIozZshfpm2SnETZRkHesdtxVUmIct90CXLuNa8A1Aa4YgPVAGg6WFkdExXz51J
	 80OGoilIWKVWw==
Date: Tue, 25 Jul 2023 16:22:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: ngbe: add ncsi_enable flag for
 wangxun nics
Message-ID: <20230725162234.1f26bfce@kernel.org>
In-Reply-To: <6E913AD9617D9BC9+20230724092544.73531-2-mengyuanlou@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
	<6E913AD9617D9BC9+20230724092544.73531-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 17:24:58 +0800 Mengyuan Lou wrote:
> +	netdev->ncsi_enabled = wx->ncsi_hw_supported;

I don't think that enabled and supported are the same thing.
If server has multiple NICs or a NIC with multiple ports and
BMC only uses one, or even none, we shouldn't keep the PHY up.
By that logic 99% of server NICs should report NCSI as enabled.

