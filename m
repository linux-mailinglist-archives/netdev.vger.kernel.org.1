Return-Path: <netdev+bounces-26954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1270779A6A
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA41C20AB4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DD329D8;
	Fri, 11 Aug 2023 22:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08B8833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1EFC433C8;
	Fri, 11 Aug 2023 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691791707;
	bh=MTgwBMCn+JkVAJDcoGKRaEkIN/v48klljD9eqmvjNIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qtI4sbTE9Bq+KPLgjRdeJgbMBxdXa1RjPgWR93egrfvsE0rLj4Cq5LdqdAACfcQol
	 NWk3p3AVJl54yEjtnq6hwLfE/Ulxo3KUzLJxdL+QbFbfeJBp3YY8k5hgNxk0Na05pl
	 MliF8HAc3vPIaU/JBIuq2xzlLLkmHAkjb6o63+8KQcDOf2GvcMP0PY3E+p8uXYwN6e
	 6pT/vTnYZnrzjP6kdAhc+aXkJgPTkUzv1hfvzM1+Jr1fVcCcm6y7sYQ4/wcgOCoXUj
	 ZLMTcy75udUd18JxR+/yBfJYXweCj2TaUI9qInsqSqJJ+bIOT6/ST0r9JADXJi427p
	 rhteQbK90LncQ==
Date: Fri, 11 Aug 2023 15:08:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
 manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
 skalluru@marvell.com, VENKATA.SAI.DUGGI@ibm.com
Subject: Re: [Patch v5 2/4] bnx2x: factor out common code to
 bnx2x_stop_nic()
Message-ID: <20230811150826.454b63dd@kernel.org>
In-Reply-To: <20230811201512.461657-3-thinhtr@linux.vnet.ibm.com>
References: <20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
	<20230811201512.461657-1-thinhtr@linux.vnet.ibm.com>
	<20230811201512.461657-3-thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 15:15:10 -0500 Thinh Tran wrote:
>  }
> +void bnx2x_stop_nic(struct bnx2x *bp, int disable_hw)
> +{

nit: empty line between closing bracket of previous function and the
beginning of the new one, please (checkpatch --strict should hopefully
point that out, although I haven't confirmed).

