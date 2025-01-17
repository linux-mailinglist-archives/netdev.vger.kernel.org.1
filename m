Return-Path: <netdev+bounces-159336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849F5A15268
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26521614CE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659EC187550;
	Fri, 17 Jan 2025 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KseTrXiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635811946C7
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126496; cv=none; b=aQNv8MPKkbR0OIkU8ea7ZJKWWwzqCli5hfTJ0jllBnKCjiWycKTRpdMPmNWc4MsPxdu1Bk9vvFyouWaU+xRl0PXQAML6ZFzfnVc/Eo25PlJLIYvTxuyPB/UH6MAASQ5Cpv40/qoa1+10hNCGgvVRWRElm0iZfiqSoy4tFrDO5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126496; c=relaxed/simple;
	bh=mwsMUiN3OWwccU+CQqZ2ql3gJIDPv94C4jfpR9td+ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKY4sD4AVOA3j4UXqu+x9n1UGQykntS1M73OAnV87uS+SBQpZLK9wiZkZjK2y5fphDik0Rv1e+yoDJVFs4vqwGrIQ8bixYY6b1BateU54Q7I8lSdhlid4Dwy3YHj6CBcpIaHT6MQqgaSDlChCilYPIYVri6jciIbdmMHGGUdcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KseTrXiL; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1737126484;
	bh=mwsMUiN3OWwccU+CQqZ2ql3gJIDPv94C4jfpR9td+ck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KseTrXiL2tQxwJ1SD8QTxDa/GhpVzXtrAxOIswlL56xpVN8BwxNTCWhYh9VGF34u+
	 /Kld3CN1ts7CAJXBrNQ/hHScfIexZv/mLmGzT/nPgSlstak367TxELToGHeyMoGsxp
	 dsJ3I2HlIM+dn54FiXahzbdsMGEg+4peYWm94kQNfrA65pRGwD6lBWjnoLXQiL0Xr1
	 e1j6BiWZrfUuoHoU+MaM/uxc2gCSDR4SO9K5aG1WNEdB8VqbvbT5zdJ+1BzGW67caw
	 HGwpcVYvfynbYFuU6yj9/oLJ9QoPXZOF518rwz5ITn2ysN5MccgWqnyGgwsQZa/Lus
	 Xs8YjylHDem6Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D5AF760078;
	Fri, 17 Jan 2025 15:08:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id D75D4200339;
	Fri, 17 Jan 2025 15:07:57 +0000 (UTC)
Message-ID: <741cd05e-e62a-4d72-b85f-ebc627b1e4d3@fiberby.net>
Date: Fri, 17 Jan 2025 15:07:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net: sched: refine software bypass handling
 in tc_run
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Shuang Li <shuali@redhat.com>
References: <76c421c64c640f5a5868c439d6be3c6d1548789e.1736951274.git.lucien.xin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <76c421c64c640f5a5868c439d6be3c6d1548789e.1736951274.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/15/25 2:27 PM, Xin Long wrote:
> This patch addresses issues with filter counting in block (tcf_block),
> particularly for software bypass scenarios, by introducing a more
> accurate mechanism using useswcnt.
> 
> [...]
>    The improvement can be demonstrated using the following script:
> 
>    # cat insert_tc_rules.sh
> 
>      tc qdisc add dev ens1f0np0 ingress
>      for i in $(seq 16); do
>          taskset -c $i tc -b rules_$i.txt &
>      done
>      wait
> 
>    Each of rules_$i.txt files above includes 100000 tc filter rules to a
>    mlx5 driver NIC ens1f0np0.
> 
>    Without this patch:
> 
>    # time sh insert_tc_rules.sh
> 
>      real    0m50.780s
>      user    0m23.556s
>      sys	    4m13.032s
> 
>    With this patch:
> 
>    # time sh insert_tc_rules.sh
> 
>      real    0m17.718s
>      user    0m7.807s
>      sys     3m45.050s

I assume that you have tested that these numbers are still roughly the same for v3?

> [...]
>   DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
> @@ -4045,10 +4045,13 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
>   	if (!miniq)
>   		return ret;
>   
> -	if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
> -		if (tcf_block_bypass_sw(miniq->block))
> -			return ret;
> -	}
> +	/* Global bypass */
> +	if (!static_branch_likely(&tcf_sw_enabled_key))
> +		return ret;

I have tested with both static_branch_likely() and static_branch_unlikely(),
but my results are inconclusive, I don't see a significant difference in my tests,
but it cases a lot of changes in the object code.

$ diff -Naur <(objdump --no-addresses -d dev_likely.o) \
              <(objdump --no-addresses -d dev_unlikely.o) | diffstat
  62 |  156 ++++++++++++++++++++++++++++++++++----------------------------------
  1 file changed, 79 insertions(+), 77 deletions(-)

> +
> +	/* Block-wise bypass */
> +	if (tcf_block_bypass_sw(miniq->block))
> +		return ret;
>   
>   	tc_skb_cb(skb)->mru = 0;
>   	tc_skb_cb(skb)->post_ct = false;
> [...]

When I run the benchmark tests from my original bypass patch last year,
I don't see any significant differences in the forwarding performance.
(Xeon D-1518, single 8-core CPU, no parallel rule updates).

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

