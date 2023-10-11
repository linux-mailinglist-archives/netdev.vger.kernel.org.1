Return-Path: <netdev+bounces-39790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3863C7C47D6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC70281E93
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5CF354F1;
	Wed, 11 Oct 2023 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJeTP3e+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E851610B;
	Wed, 11 Oct 2023 02:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224A4C433C7;
	Wed, 11 Oct 2023 02:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696991681;
	bh=FIVK2LFMNaBYWMWiLVN8ylTMPWm33ozh0ZjII2bqVP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJeTP3e+xhussaXir+c6WTyVo+EfMBXdFNtepz9PD+zZVgDgVGD/uZyBO+9xvPeeT
	 8f3XJPp8hZDPu3TG9MTF8j2aUcJKuL7jcJoJGrMO5UcQ/sZ9GRtylOTX0l1aEP/nx6
	 DbOzmS4tIkU3YSwh2f/0hUjnAWQfthYchudcg7Bbjf7fy2n2nyLtyKdgPQREvXaE0/
	 ruIL1ISvTJIJRTm+61P+y7DdiNO3vL9G2Oe/vYPfaGIclx6GWbIG3hVEQhEwRPntvP
	 KDgQSN5MpsZGrxi7iEPRsgdufLUJLLlyfl6a4fsF4YKgNbWd/yffgJryPL2bGN7UXW
	 YYW5VvlJY372w==
Date: Tue, 10 Oct 2023 19:34:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 corbet@lwn.net, davem@davemloft.net, pabeni@redhat.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 0/5] dpll: add phase-offset and phase-adjust
Message-ID: <20231010193440.76f93d5c@kernel.org>
In-Reply-To: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
References: <20231009222616.12163-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 00:26:11 +0200 Arkadiusz Kubalewski wrote:
> Improve monitoring and control over dpll devices.
> Allow user to receive measurement of phase difference between signals
> on pin and dpll (phase-offset).
> Allow user to receive and control adjustable value of pin's signal
> phase (phase-adjust).

Does not apply, please rebase / repost.

