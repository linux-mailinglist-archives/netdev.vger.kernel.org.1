Return-Path: <netdev+bounces-279726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAsMETgU5mnRrAEAu9opvQ
	(envelope-from <netdev+bounces-279726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:55:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2B42A533
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49AF530010CB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BC39E6E4;
	Mon, 20 Apr 2026 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="OoaLV34H"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2639D6DD
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686134; cv=none; b=KnjbI4gio9Z5ZCBS9Lwbe2HYyQVlJkcUNxAeLRADSYgru+6IS6a1aCuYt10Smc+LV/IT/vCvVAGDPWHHvqu0zODWSRrcY8ptaXwOkq4VvvsDDLKR2RP7ArQhI0f4wqT+Vq/xpWeUfUO2OkN737j55OnGRZFub1QXL/WUWgTZv0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686134; c=relaxed/simple;
	bh=WVdGZp9554SnWtFKvi7uy4dxvYcb+OYIS8Nm7G5T5Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj/yBYfin/FM/avHI9B5S9H7OHKTrenFXwiO/hDxPbsYJZ21RH7e+yNfGE+mvaf3EsPkPHa1UyS6dWj8Ixg9G1i2h6RXmSxup8hbNsCMSE+2I2Tz/2LFoEnB/qQcGrXmo8+YEzQsl3azvxPnAtRXgPnXSMyTIF3jqV67joXputg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=OoaLV34H; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63KBsfn0010776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Apr 2026 20:54:42 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=mLyLgYNG35p23O+WNAqn9hmPYz/m1CGJ031eEkBqKmo=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776686082; v=1;
        b=OoaLV34HkWT/IJt7fNcS9qKT1yf6xd4Rgr0cEckBVEg0F33zDGB82eAFJWq7yPrY
         Mi37LrqV5/AzONXQT4X+jKcIsiXJKTtivO3dH8/XV35AfFSEqGN0ewoIqpCMO2e5
         u34ZtFRljdG/QLXHIITX62sGRyH8gv2uHGLz7uN5MFVJnUT2HzOzvZx00kIT0sPE
         Vw+Mw5vWv+Ydf55VrormBsjYLwaZ17mYmTwAgkxk2adJld9ynWRdArfKgU/9sPzW
         kR8VcrvDzw0RkZFeLNaJtdnnicoHNe1GfkAFxLYYjkwo1Gd+Hx5+Z/Aw0Fo4nBRr
         rEDmpldW7VdTtSxTljNdqA==
Date: Mon, 20 Apr 2026 20:54:41 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
Message-ID: <aeYTImGIRuOf72mi@x1>
References: <20260420105427.162816-1-kohei@enjuk.jp>
 <b943ec1e-417c-4157-ab19-b34aa6d63688@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b943ec1e-417c-4157-ab19-b34aa6d63688@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279726-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: D3A2B42A533
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/20 19:27, Jiayuan Chen wrote:
> 
> On 4/20/26 6:54 PM, Kohei Enju wrote:
> > Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
> > skb->napi_id shares storage with sender_cpu. RX tracepoints using
> > net_dev_rx_verbose_template read skb->napi_id directly and can therefore
> > report sender_cpu values as if they were NAPI IDs.
> > 
> > For example, on the loopback path this can report 1 as napi_id, where 1
> So I think veth_forward_skb->__netif_rx could be affected as well?

Yes. Just in case, I've confirmed the same behavior in the veth path.
The mentioned loopback path is just a single example of possibly
affected paths.

Thanks,
Kohei

> > comes from raw_smp_processor_id() + 1 in the XPS path:
> > 
> >    # bpftrace -e 'tracepoint:net:netif_rx_entry{ print(args->napi_id); }'
> >    # taskset -c 0 ping -c 1 ::1
> > 
> > Report only valid NAPI IDs in these tracepoints and use 0 otherwise.
> > 
> > Fixes: 2bd82484bb4c ("xps: fix xps for stacked devices")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> >   include/trace/events/net.h | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> > index fdd9ad474ce3..dbc2c5598e35 100644
> > --- a/include/trace/events/net.h
> > +++ b/include/trace/events/net.h
> > @@ -10,6 +10,7 @@
> >   #include <linux/if_vlan.h>
> >   #include <linux/ip.h>
> >   #include <linux/tracepoint.h>
> > +#include <net/busy_poll.h>
> >   TRACE_EVENT(net_dev_start_xmit,
> > @@ -208,7 +209,8 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
> >   	TP_fast_assign(
> >   		__assign_str(name);
> >   #ifdef CONFIG_NET_RX_BUSY_POLL
> > -		__entry->napi_id = skb->napi_id;
> > +		__entry->napi_id = napi_id_valid(skb->napi_id) ?
> > +				   skb->napi_id : 0;
> >   #else
> >   		__entry->napi_id = 0;
> >   #endif

