Return-Path: <netdev+bounces-16998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D774FC61
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8AA1C20E33
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68409374;
	Wed, 12 Jul 2023 00:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A91362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55CDC433C7;
	Wed, 12 Jul 2023 00:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689122976;
	bh=/otTffP+Rna5dcWNbnypsa4RAKd0Wxfs459cCSUKR7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iSNe25vf4iH0E5TfqTUNf1Y2FKUDz1O21DNpMu31jcnqJkMMM3Sgj04XhBPnghx6w
	 O5vVwIhs8VONZmsxQVijl1BOWplOe0qp793YIwKGt/iILdfDd7mzLWGceoviO3frTf
	 u9breU+o+IFSllTIBAIGWa5kGkOO+HDqGJmke4AFgny8ax+vGjoVElKkbP9mxTfuV3
	 doL+5URKH2BGfxqvfwEJx+sVWDpJUWOSsek+5C6cQKZT/42EdsiwpKNLOdZJ9UEAAi
	 h+szlRNiR9h77JSvXgoiWZjvb4lGaRlBKDO+bk2f3YSrMKXGKINKHjxzanLo8AaQXy
	 AiohJDegFt3Og==
Date: Tue, 11 Jul 2023 17:49:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Harry Coin <hcoin@quietfountain.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, netdev@vger.kernel.org
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if
 bridge in non-default namespace.
Message-ID: <20230711174934.3871fb61@kernel.org>
In-Reply-To: <cacc74f8-5b40-4d89-a411-a6852ea60e7d@lunn.ch>
References: <f01739c8-8f59-97d6-4edc-f2e88885bb73@quietfountain.com>
	<20230711183206.54744-1-kuniyu@amazon.com>
	<3dceb664-0dd5-d46b-2431-b235cbd7752f@quietfountain.com>
	<cacc74f8-5b40-4d89-a411-a6852ea60e7d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jul 2023 22:44:44 +0200 Andrew Lunn wrote:
> o It cannot be bigger than 100 lines, with context.

Let's take stable rules with a large pinch of salt.
None of them are hard rules, especially the 100 line one.

