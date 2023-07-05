Return-Path: <netdev+bounces-15578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F67B7489D7
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D8628103D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441612B69;
	Wed,  5 Jul 2023 17:08:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE49470
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69377C433C8;
	Wed,  5 Jul 2023 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688576893;
	bh=fnSrPawt/TnW37jkBzLgdNFNVu0XN8tj+ltnisBmrJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aOP/KN5oz66gfAVyzUXIhz6LHZX26zb4CW1jLg+YYQUPfHYAquXvLu1uoxBN2qaLX
	 T3srtmNyxYNgNIVklq+Xdnt4S8liwlGEwzCY1lKm7mefTku/Ri8i+NDV07KL45aLtK
	 v4PqPww0ajZrVxURTSkBU9T1t+ptR/rOjlxpetl4JKpKkBbPJ3guE+FFgtE56ZRgsX
	 NfYoCZMBJVDe2OYYH/SXO0bGd2S1MVK7fFAU6JRXK01owDuvivaXt3wzdTCBP0RP5M
	 1d/H1R+qZN4Y/blJweARZp2dabofBqxCJzsIK0x3MB88oAnFAvlhaTgo2QvPxdRZSe
	 kVgReOPMfYTpw==
Date: Wed, 5 Jul 2023 10:08:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, pctammela@mojatatu.com, simon.horman@corigine.com,
 kernel@mojatatu.com
Subject: Re: [PATCH net v2 1/5] net: sched: cls_bpf: Undo tcf_bind_filter in
 case of an error
Message-ID: <20230705100812.011ab384@kernel.org>
In-Reply-To: <20230705134329.102345-2-victor@mojatatu.com>
References: <20230705134329.102345-1-victor@mojatatu.com>
	<20230705134329.102345-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jul 2023 10:43:25 -0300 Victor Nogueira wrote:
>  static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
>  			     struct cls_bpf_prog *prog, unsigned long base,
>  			     struct nlattr **tb, struct nlattr *est, u32 flags,
> -			     struct netlink_ext_ack *extack)
> +			     bool *bound_to_filter, struct netlink_ext_ack *extack)

Output argument, and an 8th argument of a function at that is too ugly.
Please find a better way to fix this.
-- 
pw-bot: cr

