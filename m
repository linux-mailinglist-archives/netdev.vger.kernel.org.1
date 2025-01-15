Return-Path: <netdev+bounces-158329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD9A11682
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364607A297A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0B3597F;
	Wed, 15 Jan 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy4COhmn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8A35945
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904381; cv=none; b=lkDOy06qu4lBEwwrBdzosJ63EQfzHVar7XA92OnH2El/VUIqqfsHRZcVoEzM1mdpDHYRX0vExDlEpj/NNkaS09sbm1Ytn/EtFGJmGs2GgEt5G4NAuHuAxgDVDYn03ZG5C7HcfQTbo4+Bwmm80RnnuhQaID+LDW76YtUZuLoX06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904381; c=relaxed/simple;
	bh=MLSmt7trNP0lQu5BawmK21LK4IMgLz260mS0YqNPeg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5v3v6Hyut7Mdn7RQJv8atkXREv312xocGZAxV7bP+deYf6LPaAyuokkQOyeyxIofTaIYY2kD9RQ4H2YHf7SK0WQm054XeZp//4HOQdSFCX6SHG5pui8mYt8zo0XTtjmPGyYxTcg8HZGklguMSB23NoZ65vtidbWdqi3GHcIrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy4COhmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F06C4CEDD;
	Wed, 15 Jan 2025 01:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736904381;
	bh=MLSmt7trNP0lQu5BawmK21LK4IMgLz260mS0YqNPeg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qy4COhmnMDu80sCAFp2D5CaN6ygDCI0cIsRisASP8QLRPlJ3+srt0hAXZ395A1Nlh
	 NkIViiB7SCdIRfXDEO9HnD1seJ/HPekhBeZuKzRN9z1yyau0gct2MMNB5sOwqbWXqo
	 nKw4txvAIAzWph64MxsjE7pcUMnHpRJhxkwYM/mh2lcr/FEC5NO4TBlUqWK/lLxQo8
	 zgOFQGbTpW375wabaSzXWZwQoNlbdJ3uPUgWCQJpIoAkCwRuUwjsZhptQ/ao40+qhI
	 2l6kYB53V1HxUwLPE02UQJvwTQtbvTl76Mtw3tPUKPowqQWh0Uj2v2QlCYIbcNIos0
	 gPzOyfYjdCXyg==
Date: Tue, 14 Jan 2025 17:26:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, security@kernel.org,
 nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child
 qdisc from one parent to another
Message-ID: <20250114172620.7e7e97b4@kernel.org>
In-Reply-To: <20250111151455.75480-1-jhs@mojatatu.com>
References: <20250111151455.75480-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 10:14:55 -0500 Jamal Hadi Salim wrote:
> The semantics of "replace" is for a del/add _on the same node_ and not
> a delete from one node(3:1) and add to another node (1:3) as in step10.
> While we could "fix" with a more complex approach there could be
> consequences to expectations so the patch takes the preventive approach of
> "disallow such config".

Your explanation reads like you want to prevent a qdisc changing
from one parent to another.

> +				if (leaf_q && leaf_q->parent != q->parent) {
> +					NL_SET_ERR_MSG(extack, "Invalid Parent for operation");
> +					return -EINVAL;
> +				}

But this test looks at the full parent path, not the major.
So the only case you allow is replacing the node.. with itself?

Did you mean to wrap these in TC_H_MAJ() || the parent comparison 
is redundant || I misunderstand?

