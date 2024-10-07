Return-Path: <netdev+bounces-132757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EADD993035
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14CF1F23E9A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8F1D6DAE;
	Mon,  7 Oct 2024 14:57:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB611D2B35
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313044; cv=none; b=WB5bxfDz+FfM/kESJCeNREu/O2K7Yom007bs6ZSV07X3yDY3cc8gULbo2IZK6isjxpI2AkZsqA1739r7y2QJZtcSHMXznE2FgD4tu62o9aGQb8/DDKXFHj6bJAQyjFf+9F6lBLyiLHwFl25/oPCGd2XP0k7l4I+kt+EpoaxCIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313044; c=relaxed/simple;
	bh=IFUHodKCbsnrifi01l3w+LiPZ5E3LtH8rgpj6AMbHZo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=GDTDYyzAz1m8d+L0+MXLL98wIVuoJ0xbmfMim3aqdBPKvk4p2iz9IlVxluY2yLA3k5EUpO4cuKCqCrwZOhiVzJnDE97ZiLkKXrE6HZp09lajEF8/5d947+Zzwdks1l4VEPjsvmY/8rhXrSK8O46XTmQZfd04ux6xfk/GwAPu+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:33350)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sxpAe-00Bc8l-UB; Mon, 07 Oct 2024 08:57:12 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:50190 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sxpAd-00FKPp-Q6; Mon, 07 Oct 2024 08:57:12 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Kuniyuki Iwashima <kuni1840@gmail.com>,
  <netdev@vger.kernel.org>
References: <20241007124459.5727-1-kuniyu@amazon.com>
	<20241007124459.5727-6-kuniyu@amazon.com>
Date: Mon, 07 Oct 2024 09:56:44 -0500
In-Reply-To: <20241007124459.5727-6-kuniyu@amazon.com> (Kuniyuki Iwashima's
	message of "Mon, 7 Oct 2024 05:44:58 -0700")
Message-ID: <87h69ohsgj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sxpAd-00FKPp-Q6;;;mid=<87h69ohsgj.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19KLk7+QQ7X1k8fATQV1a3yHz+N0z+j4Co=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kuniyuki Iwashima <kuniyu@amazon.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 515 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.14
	(0.2%), extract_message_metadata: 14 (2.7%), get_uri_detail_list: 2.3
	(0.5%), tests_pri_-2000: 14 (2.7%), tests_pri_-1000: 2.6 (0.5%),
	tests_pri_-950: 1.40 (0.3%), tests_pri_-900: 1.05 (0.2%),
	tests_pri_-90: 125 (24.3%), check_bayes: 123 (23.9%), b_tokenize: 10
	(1.9%), b_tok_get_all: 8 (1.6%), b_comp_prob: 3.0 (0.6%),
	b_tok_touch_all: 98 (18.9%), b_finish: 1.09 (0.2%), tests_pri_0: 325
	(63.2%), check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 10 (1.9%),
	 poll_dns_idle: 0.49 (0.1%), tests_pri_10: 2.2 (0.4%), tests_pri_500:
	14 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 net 5/6] mpls: Handle error of rtnl_register_module().
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: netdev@vger.kernel.org, kuni1840@gmail.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, kuniyu@amazon.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

> Since introduced, mpls_init() has been ignoring the returned
> value of rtnl_register_module(), which could fail.

As I recall that was deliberate.  The module continues to work if the
rtnetlink handlers don't operate, just some functionality is lost.

I don't strongly care either way, but I want to point out that bailing
out due to a memory allocation failure actually makes the module
initialization more brittle.

> Let's handle the errors by rtnl_register_many().

Can you describe what the benefit is from completely giving up in the
face of a memory allocation failure versus having as much of the module
function as possible?

> Fixes: 03c0566542f4 ("mpls: Netlink commands to add, remove, and dump routes")

A fix?  Not really no.  You are making the code work less well in the
face of adversity.  I really don't think that is a fix.  Certainly not
without a better justification.

I get this as a code cleanup to make things more uniform and easier
to reason about.  Still you are adding more code paths that are going
to go untested so I don't see how this winds up being any better
in practice that deliberately limping along.

Eric


> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  net/mpls/af_mpls.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index aba983531ed3..df62638b6498 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2728,6 +2728,15 @@ static struct rtnl_af_ops mpls_af_ops __read_mostly = {
>  	.get_stats_af_size = mpls_get_stats_af_size,
>  };
>  
> +static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_module = {
> +	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
> +	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
> +	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes, 0},
> +	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
> +	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
> +	 RTNL_FLAG_DUMP_UNLOCKED},
> +};
> +
>  static int __init mpls_init(void)
>  {
>  	int err;
> @@ -2746,24 +2755,25 @@ static int __init mpls_init(void)
>  
>  	rtnl_af_register(&mpls_af_ops);
>  
> -	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_NEWROUTE,
> -			     mpls_rtm_newroute, NULL, 0);
> -	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_DELROUTE,
> -			     mpls_rtm_delroute, NULL, 0);
> -	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_GETROUTE,
> -			     mpls_getroute, mpls_dump_routes, 0);
> -	rtnl_register_module(THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
> -			     mpls_netconf_get_devconf,
> -			     mpls_netconf_dump_devconf,
> -			     RTNL_FLAG_DUMP_UNLOCKED);
> -	err = ipgre_tunnel_encap_add_mpls_ops();
> +	err = rtnl_register_many(mpls_rtnl_msg_handlers);
>  	if (err)
> +		goto out_unregister_rtnl_af;
> +
> +	err = ipgre_tunnel_encap_add_mpls_ops();
> +	if (err) {
>  		pr_err("Can't add mpls over gre tunnel ops\n");
> +		goto out_unregister_rtnl;
> +	}
>  
>  	err = 0;
>  out:
>  	return err;
>  
> +out_unregister_rtnl:
> +	rtnl_unregister_many(mpls_rtnl_msg_handlers);
> +out_unregister_rtnl_af:
> +	rtnl_af_unregister(&mpls_af_ops);
> +	dev_remove_pack(&mpls_packet_type);
>  out_unregister_pernet:
>  	unregister_pernet_subsys(&mpls_net_ops);
>  	goto out;

