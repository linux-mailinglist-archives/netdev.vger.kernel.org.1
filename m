Return-Path: <netdev+bounces-266784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOGMMNHnsWkyHAAAu9opvQ
	(envelope-from <netdev+bounces-266784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:08:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722C26AC6B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94081300D36F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F38374171;
	Wed, 11 Mar 2026 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2ajF0F7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95058368958
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266894; cv=none; b=ub6wI353Jvj0lhgGcauRdEujA2X8J1356gZQ25TVNFlH69uSm8g+4nrR6ykrNxWpNc3nIYzHPIJlLtCZUmHMyxuDuLEXO7k5Idr4+Fubt+Ukpg3HU0Z7Kit5EFLhO0DrrGQKpKIDas0MrK3ZGR+ITqaOWZRWHKTkIlY2UkPpSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266894; c=relaxed/simple;
	bh=eckzTySEcXipLe+VU78GzpoVPoQ+1K7RQ8jMl1qup7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLxwwCDefsThkNqYUsxdliBcF+Zc/J5fVCMcQOtVqS41GoBxSJ1XFl8P6kGPMI1mi2+1afsTYTNgfmhuVy+c372lSbm5FrAOchZkvQgrkGwiX8gbBxbNUIV8NR/3Z14NkW5d7YzGc+M9nLO7JfVRHCQbxZhgcNhzteCRcOZHcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2ajF0F7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso3057505e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773266890; x=1773871690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXJIXQ3qsiPhJua6yI0vMRP9sGOp7VDYpCWyFHFNhZU=;
        b=m2ajF0F7tZ3pWTkmxKLpUvcukAjc418XjqfW3veoVlHoJf/+u6zefr92CIEXoZE65+
         N+c0izwroUGApIkU1EJaMw+0dC+KnGd0e9QVQcmEOi1/82fpm6vN5A4VzvS0q+Rs7RMt
         d3P3z2CndMqf9v48cUnC/PXQ9CmRIDb0bmX9brh+H2L6OVefBA5W1uN6VuOIhOxpqVak
         nrwi1GYtK3NHOmOT9JAgW9ABrz7561JZokhXkdx3G6kWc4UBbmdQk1TRPhP9Mycb8IMr
         KfKC+BMcjJfSZv4OVsZymuuD88+Ty0WkuwE+27mP+qt7FUX4vhy3oNVUeQ6yvQ1sRPc8
         86mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773266890; x=1773871690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXJIXQ3qsiPhJua6yI0vMRP9sGOp7VDYpCWyFHFNhZU=;
        b=RrhJqmLTpKO3dHdZsgH3IximMtRzPOocrnySOw1rwRcWbX+xlFFFUX4f4Br3wecMDY
         w1eKh7G6SZJKXu9qVoMXIAZrQb6eaVqG6RKGjXCXqpFYbsDW7VG2iv5iBtwhmuePawyJ
         LCX7dM/cYTBV4LPPkFeH4LoyvLyNcij/LXEC91DMTPE3sgSH++wEEn4ZGB+Ety2ketQ+
         dXTVTTlt7IZW9ypyGG2r92dCzdGm2wHiOVYXbpBAGn+6IgoPef0O5Y1zVGAVBmy80Dzv
         j4HBUq+OQhiXqkdHwVqkx18+Jg9ExcIhnOshMttVKo9O343Hn8YJhsu4cJZlxNUZeA/z
         J/YA==
X-Gm-Message-State: AOJu0YyzTBnuMOUfgi8ha8PfX+CDShJ3Br1PKdvJB42d/YziyFtKnp2o
	lv9hBksGs6wEN5SfiWDdC8hFJwd5rwC3RIQ4lWU91kkxtle6IeG+fp4o
X-Gm-Gg: ATEYQzxhTbYHfnt+M+X9Gs9zahKts0lkKYC04Ihuk/DBWYXELzBbYwC3atdgWY7OQdz
	+kGEoOrnsyuF6AB7QYhon+qsgbjwfXSgWjd+7snqdXQiu/NmcaDQeOw18t/kJOikltcvnpjWRCH
	AUTqnKc/IxKuoCeQGdLEYc50Jf7HV9K1mjFrxKxKA+5gHjDlHWYoaJ+Z2JUVgGVCWYFEEKomDdq
	Q35Xw0uAZQ/VOxx5t9Ol3txnLvXE7eJ5RX2PkwifBhia8jY3KKxN0bSe0MDa6Adi486NZJo2NxJ
	z16m7QxCT9Io76PK1d8QsCQP0jonHaR5wWe8IgIQcYSsmBpsXOsJvuX39talIUoiihi0+BPdA5g
	saFID5pyWkM4YLT17wL7nIEJN5pLZPhVK/menpDKFgYBxBSGRi4IJJ6JUrLwHA2oHjhgf2NfP2c
	AgMHjBHzCYrYCQS7tgJm62QPzV2Od4CQS3wPu9YQVjI0EhleLfUmGvoXe5tX+Baao0tPhV7N1D
X-Received: by 2002:a05:600c:3b16:b0:485:3e6c:aabc with SMTP id 5b1f17b1804b1-4854b107dddmr62988565e9.19.1773266889508;
        Wed, 11 Mar 2026 15:08:09 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2ef5.dip0.t-ipconnect.de. [91.46.46.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm512043875e9.2.2026.03.11.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:08:09 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 989BA302FC8A; Wed, 11 Mar 2026 23:08:08 +0100 (CET)
Date: Wed, 11 Mar 2026 23:08:08 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net-next v3 2/6] mptcp: keep rcv_mwnd_seq in sync with
 subflow rcv_wnd
Message-ID: <abHnyJInqmGNIWiq@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
 <334053df-9824-4bfe-b37c-8711d0a5a9bd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334053df-9824-4bfe-b37c-8711d0a5a9bd@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-266784-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gandalf.schnuecks.de:mid]
X-Rspamd-Queue-Id: 6722C26AC6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Matt,

On Wed, Mar 11, 2026 at 07:27:34PM +0100, Matthieu Baerts wrote:
> Hi Simon,
> 
> On 09/03/2026 09:02, Simon Baatz via B4 Relay wrote:
> > From: Simon Baatz <gmbnomis@gmail.com>
> > 
> > MPTCP shares a receive window across subflows and applies it at the
> > subflow level by adjusting each subflow's rcv_wnd when needed.  With
> > the new TCP tracking of the maximum advertised window sequence,
> > rcv_mwnd_seq must stay consistent with these subflow-level rcv_wnd
> > adjustments.
> 
> Thank you for these modifications!
> 
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  net/mptcp/options.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 43df4293f58bfbd8a8df6bf24b9f15e0f9e238f6..8a1c5698983cff3082d68290626dd8f1e044527f 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> 
> (...)
> 
> > @@ -1338,8 +1339,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
> >  		 */
> >  		rcv_wnd_new = rcv_wnd_old;
> >  		win = rcv_wnd_old - ack_seq;
> > -		tp->rcv_wnd = min_t(u64, win, U32_MAX);
> > -		new_win = tp->rcv_wnd;
> > +		new_win = min_t(u64, win, U32_MAX);
> > +		tp->rcv_wnd = new_win;
> 
> Out of curiosity, why did you change the two lines above?
> (even if it makes sense, the diff is a bit confusing, and the commit
> message doesn't mention this :) )

I wanted to keep tcp_update_max_rcv_wnd_seq() calls close to the
respective update sites (same pattern everywhere).  In the original
form

tp->rcv_wnd = min_t(u64, win, U32_MAX);
tcp_update_max_rcv_wnd_seq(tp);
new_win = tp->rcv_wnd;

the ordering suggests that tcp_update_max_rcv_wnd_seq() might modify
tp->rcv_wnd.

So, I changed it for legibility.  Now, I realize it made the
diff harder to read.  I might have optimized the wrong metric here ;-)

> 
> > +		tcp_update_max_rcv_wnd_seq(tp);
> 
> 
> This patch adding this new helper each time rcv_wnd is modified looks
> good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> 
> Note: just in case a new version is needed, checkpatch reported an error
> in patch 4/6 because of a trailing whitespace (+ No space is necessary
> after a cast in patch 1/6), see:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/22844479818

Thanks. I will change that if there is a v4.


-- 
Simon Baatz <gmbnomis@gmail.com>

