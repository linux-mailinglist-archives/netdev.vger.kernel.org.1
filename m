Return-Path: <netdev+bounces-245480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAEACCECCD
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D61423006A5E
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED61227EA8;
	Fri, 19 Dec 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="5qnVYYht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C141991CB
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129844; cv=none; b=SuDPdwhPzI+h1/cODZR4ZKkJTUBn38nhpYoQPs+8mvUyAIXX73+acedIWAguOyIFuBtuaRlLLvEQHkz6tsiutniaUL+u9HJR+mcfUVLzThi1/Hwxbck8AuMrvHZ/uTlGXP8gQpPLBbHNxtyauQ+3N2ehRfqwraMTiw/4cJVjxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129844; c=relaxed/simple;
	bh=Dk0J5SbprSuHIFt8EQMs4wy6zIcWkrCEIa//jFN4vaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUlMSUUKOVpoQGGIPW+ryciGyUFr4RfvEN9jPlbOLk1LGWpdtY/ugQHfr/w31wTE1n9Z4IgrX3svoTaA8I2jwe9eWYUeXc6EwQyobS+p5MSNBJH6dLfWlBqe+RLEPA5nWvUA07PK37qn1DV86ECIc2cv53w9v1seDtIySSjDixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=5qnVYYht; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1766129839; x=1766734639; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=8Bbj5aG9+FyEl1569LcYPU6BfTLqdej1g96JkOLVTeM=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=5qnVYYhthMxjZM2HihqmWRntRGNMdidFCqwA2be3myjhmP3DcZOvarZchgUMcjwbvA9meM06GVEgjnBfX/hiAyjjxvRyCB+MQGyWmYSoXO7c+xJLjXII2MM5xc9zmTCeCnNFz6BesVRLWCa4HIlT5U138lsIKriuezzClcoLyAQ=
Received: from [192.168.100.3] ([188.75.189.151])
        by mail.sh.cz (14.2.0 build 9 ) with ASMTP (SSL) id 202512190837182895;
        Fri, 19 Dec 2025 08:37:18 +0100
Message-ID: <04828827-e664-4fbc-b96f-ce149da7c410@cdn77.com>
Date: Fri, 19 Dec 2025 08:37:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: clarify tcp_congestion_ops functions
 comments
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20251218105819.63906-1-daniel.sedlak@cdn77.com>
 <CADVnQy=-UP9jJ5-bv=aRYL5fEtpjscDEAC1G=_cCM4gF10W8ew@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <CADVnQy=-UP9jJ5-bv=aRYL5fEtpjscDEAC1G=_cCM4gF10W8ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A2D032B.694500AF.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Hi Neal,

On 12/18/25 2:37 PM, Neal Cardwell wrote:

> 
> Perhaps something like the following.
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 10706a1753e96..d35908bc977db 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1326,12 +1326,28 @@ struct rate_sample {
>   struct tcp_congestion_ops {
>   /* fast path fields are put first to fill one cache line */
> 
> +       /* A congestion control (CC) must provide one of either:
> +        *
> +        * (a) a cong_avoid function, if the CC wants to use the core TCP
> +        *     stack's default functionality to implement a "classic"
> +        *     (Reno/CUBIC-style) response to packet loss, RFC3168 ECN,
> +        *     idle periods, pacing rate computations, etc.
> +        *
> +        * (b) a cong_control function, if the CC wants custom behavior and
> +        *      complete control of all congestion control behaviors
> +        */
> +       /* (a) "classic" response: calculate new cwnd.
> +        */
> +       void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
> +       /* (b) "custom" response: call when packets are delivered to update
> +        * cwnd and pacing rate, after all the ca_state processing.
> +        */
> +       void (*cong_control)(struct sock *sk, u32 ack, int flag,
> +                            const struct rate_sample *rs);
> +
>          /* return slow start threshold (required) */
>          u32 (*ssthresh)(struct sock *sk);
> 
> -       /* do new cwnd calculation (required) */
> -       void (*cong_avoid)(struct sock *sk, u32 ack, u32 acked);
> -
>          /* call before changing ca_state (optional) */
>          void (*set_state)(struct sock *sk, u8 new_state);
> 
> @@ -1347,12 +1363,6 @@ struct tcp_congestion_ops {
>          /* pick target number of segments per TSO/GSO skb (optional): */
>          u32 (*tso_segs)(struct sock *sk, unsigned int mss_now);
> 
> -       /* call when packets are delivered to update cwnd and pacing rate,
> -        * after all the ca_state processing. (optional)
> -        */
> -       void (*cong_control)(struct sock *sk, u32 ack, int flag, const
> struct rate_sample *rs);
> -
> -
>          /* new value of cwnd after loss (required) */
>          u32  (*undo_cwnd)(struct sock *sk);
>          /* returns the multiplier used in tcp_sndbuf_expand (optional) */
> 
> How does that sound?
> 

Thank you for your response & suggestions. This sounds like really nice 
improvement, can I use it for v2 and add you as Co-developed-by (since 
you've done most of the heavy lifting)?

Thanks!
Daniel

