Return-Path: <netdev+bounces-20592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3793E7602E6
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687B31C20C75
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5127512B69;
	Mon, 24 Jul 2023 23:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B60125CB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E32C433C8;
	Mon, 24 Jul 2023 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690239735;
	bh=hI0FdL79ONz1aw2g1iC99scsQbNuHJWqIktK0q9d2t0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b3Hg0PnxsGfHyDxuZnH9oVhSo/fPlHoGpUlKPIo/KKCaqq9MmtD+6Wwx1991G8LX8
	 fuPPoGWgcdApm3IY2/O19ElLmY3AudPAU0ErbNqhTY2mm5bPklUkMzbywOSKKDkvxr
	 LUqDUQwAG5UEgQJZ3QCBaBai3U9nEaQZ1YO37cIBsbYmjX2tQDB0UyReM5GDBqAq5r
	 oxol7DOgGyoRZVg2we88v/XRosM4QfAnMXE1rgeyqPXmPBrSia3VpfXSXS3AX43F7E
	 idGRIi3yBoXdwqvAmRrpJsI+Z3Qv641aAP3UKXQ/6DvEm1mbsfVHq/r4re7u3QHojp
	 5R0xPh7TVAyPA==
Date: Mon, 24 Jul 2023 16:02:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Message-ID: <20230724160214.424573ac@kernel.org>
In-Reply-To: <20230724014625.4087030-1-linma@zju.edu.cn>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 09:46:25 +0800 Lin Ma wrote:
> The nla_for_each_nested parsing in function mqprio_parse_nlattr() does
> not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as 8 byte integer and passed to priv->max_rate/min_rate.
> 
> This patch adds the check based on nla_len() when check the nla_type(),
> which ensures that the length of these two attribute must equals
> sizeof(u64).

How do you run get_maintainer? You didn't CC the author of the code.

