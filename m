Return-Path: <netdev+bounces-287021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO1IDGnyAmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:27:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33951DA3E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D497301628E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB047AF65;
	Tue, 12 May 2026 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2rN8cAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A63A1CEC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577913; cv=pass; b=ACMd3or5EwXum4zutuMa7m6SQn86tmLgrKKarpYQFYgh09QCehOVdt/XcAW0wbM/GCw9fx/rjmE5xQBrxTKjlRYpQlukBmhYplTYVmAInCxKAjq5N6trJ4YAmJylqKyeBplpHJptnfekYMkXeXrGtgxpxEIwt5uWUSy9dsY2amo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577913; c=relaxed/simple;
	bh=o/6U62XbaDSLrBCYv6/owErRRDaqpMXcRYRw5nP61t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3JMTMftN/hdcSInROTXDH5Oq6d4z7SD9JWn3N8xWEE97loLbwhzN841AiPNN7oK3jCkbfSaseCvRCCLOeVBTCjYDs71Mi0L7czsa7blSEEAPGSjmiZdl6yt7/5rSNuIj5LHC0L8oFhwsP0OKuSrP9BAKQ4ZM0NGZCpBarvC41g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2rN8cAy; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-902deb2412fso575476685a.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778577910; cv=none;
        d=google.com; s=arc-20240605;
        b=XiJXvmyktFrqKo6ivE7g4LI3cASnr4BMrzuUr1WYzfgXndqI1f0K0CeNBzJxPpGifW
         mfK4bcQaNXNWeUoXEUfVRMnzuQ8qncjVVXea2nSd8qIG+mbPFfL/lXszrAK6syGHngqF
         iEoZuDpbA+51mBkRtxUeuO6IHGqy/r6gfssvpxJnlnUh2baUgBSBokrouukiI4kt8+yQ
         DSJcKW80JCAHEbl0/oM8H0Takk72LJGQK8b6cU/RakLDuebNLS41eTqz1ApCssoHVv/s
         Mn0fnR74fnkfvd2fSsM76YLY0CeVojP5J3h4BJtQRofoau2ARJULZ/tytE3SQRblmKzM
         jUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02U6ivPZFeN9WHQFlvflnUeZjcIBBlBqBFePfdQqFyg=;
        fh=hzcQS6zgBAiPN7B4ayLR0+QVN656f5xa3z5dCyz6FDA=;
        b=Xsa3aB+u8gUfL1FoI8I5IUlioFtS4JFCTeL1v8JWGPjWOouIqpp57wRVXcO9/rCCPi
         7cSMjGRu/lpSbP7kB5IEDKpXzDGAX0p0aiN2slFdTXV1panvgkWvKfk5sVKHBQ457bVE
         Dc6UikIJ96dMv9RjVt5MUwH0uysIPmGsW+NmAjWLjrodtezHLFfLwQdT6yNLAK3SERdP
         2Dptxno9AsTF8skAsshho4WtWtCJ8Rfv2HiApMumgpBgyCIztjNLFZ4DRk2Saer2Mcyb
         O/e7lMS8hEbEAERl/BjqfzgPVEh/iTmmQ9wzgzLNzzMdi0/Og6Df4O9h2txlGRuhIxTF
         mC0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577910; x=1779182710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02U6ivPZFeN9WHQFlvflnUeZjcIBBlBqBFePfdQqFyg=;
        b=Y2rN8cAyq7ypzgkk0g+XhXzFGBP2gHHQ/prsAf/OAK/7TWDMBzE8Vmi3VbHQpoQ7nQ
         ht3J9V8tAYicW/ttS5692dQ6JA16PO96aEu+Pw/drRWRlvhS4N2BYaqDHroY3GB0Z8Ns
         060VKB0RIthYkGUYtFOX/VJxlCLR5S0MwAdKmi9OqUtYTVa7XbcL63y/gdSjpHlmtNVD
         n1nvEZPwh64g+CBnyhP7mFC3V2pbYcBT07CHcSvYz8x5aZQN8fRVNT07S8RBqFRVsOJl
         ZwGVgyGDevODKsUUPE03EzAqS2JpTBjwOn0LXA+vroze23ZzGyk8u2fiy2L+eFN/M7NH
         yjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577910; x=1779182710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=02U6ivPZFeN9WHQFlvflnUeZjcIBBlBqBFePfdQqFyg=;
        b=KzMwbFtzne7gbEGOFws7C7QI0UXa4MiDkXXvc80Cci1HRzrK2SmhKRqK75nUo2bNOb
         K3kvBPR6oXI6JUb48RiUl2642SicMEEyKbH/Ddfho2xfr5prWFSz3/Cx+q0u3ZPj/nr6
         Xkk+pGHBDs1kCToLkuNNwtwGPRXwkGhzAcAQxVrL7vopuxZIz9FlRDjXcKQ6AcW+b6rC
         D7vQpOBuKvDyychB2e3cUyEO/dovz8S3Aa8t6sP+3maBf5W/TDLKjmBaClXM3vfL1rUK
         33aya0/clhmlCv9/l2YuHgZdJ2CDBNRPlCld38uHsSB3eHpnj5APFmrhtSPqnH2OC4UO
         9IjA==
X-Forwarded-Encrypted: i=1; AFNElJ9hsTVrElwwOBr2YCCKBOxISzz3hp5arg1jcB9z6o78lioj/bpWLaZ4uSkcJb4CdWOPa//b6Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllBMjjle47yR8nTJeNcasvIgebmQUo98S/eujuqhsSujVW6hL
	dKXYO6HoEwNa9rOmLS26N+WxJvFSe4GJeA+TbOpK9Rs1aJ25VMr68noIFnRyxoOHFSEGJqVbmqi
	ja0xNir5Ek2gQTLzyuN9uwpMFvf120c0=
X-Gm-Gg: Acq92OFL0SYB1qrEYy1TvlKpFHpsm02efh/O8ws9+7mu71uYDoFWMyWSSLT53G6JBy6
	nn3aVYYDBFh1Y065oQ6oF4g6KfJRnzwmq1jKO8ayJvYgIPhLjcxIV27gyZF4/lrtpDFjwnpy2i/
	i10s/KJYgwVMgb1DzVOb7FaD5manzpC9CWDY1K5DE4+tBz6kieCRW36nzrkw0P1VKcOSGaeEG5p
	EDz5J7/xQEoD28U3BUf5fu3bNKlKmX6zOZl5QSs+Qm1ENRcWnvkfSA9sO8wAqA+0TFfqEHx3cT6
	+/K595w=
X-Received: by 2002:a05:6214:5890:b0:8bf:6a92:84af with SMTP id
 6a1803df08f44-8c1a379722amr191655806d6.21.1778577909973; Tue, 12 May 2026
 02:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778504155.git.tonanli66@gmail.com> <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org> <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
 <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
In-Reply-To: <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
From: Yuan Tan <yuantan098@gmail.com>
Date: Tue, 12 May 2026 02:24:57 -0700
X-Gm-Features: AVHnY4KD0TfTyan543XHPWM1ak4nMXTSylUMLtAxLtkGNTo-flKx6QChPyrFj_8
Message-ID: <CAPuPA7+jMHLjpY-RWK6-EQqs-NjrGUmanuPVVTDZJv1yeRk1oA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing port
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	idosch@nvidia.com, fw@strlen.de, davem@davemloft.net, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, tonanli66@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C33951DA3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287021-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lzu.edu.cn,lists.linux.dev,vger.kernel.org,nvidia.com,strlen.de,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,blackwall.org:email,lzu.edu.cn:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 2:03=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 12/05/2026 11:57, Yuan Tan wrote:
> > On Tue, May 12, 2026 at 1:29=E2=80=AFAM Nikolay Aleksandrov <razor@blac=
kwall.org> wrote:
> >>
> >> On 12/05/2026 07:31, Ren Wei wrote:
> >>> From: Nan Li <tonanli66@gmail.com>
> >>>
> >>> The bridge local receive path may be deferred by netfilter and resume=
d
> >>> later. By the time br_handle_local_finish() runs, skb->dev may still =
be
> >>> valid while its bridge port association has already been removed.
> >>>
> >>> br_handle_local_finish() unconditionally looks up the bridge port fro=
m
> >>> skb->dev and dereferences it for source learning. If the port is no
> >>> longer attached to the bridge, the lookup returns NULL and the deferr=
ed
> >>> local receive path can no longer rely on the port state being present=
.
> >>>
> >>> Skip the learning step when the bridge port lookup fails. In that cas=
e
> >>> there is no port state left to learn on, so returning early preserves
> >>> the normal behavior for existing ports while avoiding access to stale
> >>> state.
> >>>
> >>> Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook =
returns QUEUE or STOLEN verdict")
> >>
> >> I don't think that is the correct commit, it seems to me this bug
> >> has existed for a very long time. From a quick search I think (Florian
> >> please correct me if I'm wrong, but I think NF_QUEUE existed back then=
)
> >> it was introduced in 2010 by:
> >>    f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bri=
dge_port
> >> pointer")
> >
> >
> > After checking the history, I believe f350a0a87374 is indeed the
> > commit that introduced the underlying root cause.
> >
> > The 8626c56c8279 commit in the patch is the one that actually made the
> > bug reachable in practice. I am a bit unsure which commit should be
> > used in the Fixes: tag. We have run into this situation several times
> > already, where the commit that introduced the root cause is different
> > from the commit that actually made the bug triggerable/reachable.
> >
>
> Hmm could you please elaborate? How did that commit make it reachable?
> I can see the call was done before it as well:
>                  /* Deliver packet to local host only */
> -               if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
> -                           dev_net(skb->dev), NULL, skb, skb->dev, NULL,
> -                           br_handle_local_finish)) {
> -                       return RX_HANDLER_CONSUMED; /* consumed by filter=
 */
> -               } else {
> -                       *pskb =3D skb;
> -                       return RX_HANDLER_PASS; /* continue processing */
> -               }
> +               NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, dev_net(skb->dev)=
,
> +                       NULL, skb, skb->dev, NULL, br_handle_local_finish=
);
> +               return RX_HANDLER_CONSUMED;
>
> NF_HOOK() would return 1 for NF_QUEUEed packet so essentially it was doin=
g
> the same, how would did it make the bug triggerable?

I see. I was wrong. Thanks for pointing that out.

>
> > What do you think would be best?
> >
> > Also, if the Fixes: tag should be changed, would you prefer that we
> > resend the patch, or would you rather have the committer adjust the
> > Fixes: tag when applying it in order to reduce traffic on netdev?
> >
> >
>
> You should update the Fixes: tag but also wait 24h before re-posting anot=
her
> patch version.

Ok we will send the v2 with fix tag f350a0a87374 after 24h

>
> >>
> >> because that commit removed the same check for a NULL port.
> >> The patch itself is ok, it restores the check that was there before th=
e commit
> >> I mentioned.
> >>
> >>> Cc: stable@kernel.org
> >>> Reported-by: Yuan Tan <yuantan098@gmail.com>
> >>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> >>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> >>> Reported-by: Xin Liu <bird@lzu.edu.cn>
> >>> Signed-off-by: Nan Li <tonanli66@gmail.com>
> >>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >>> ---
> >>>    net/bridge/br_input.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> >>> index 2cbae0f9ae1f..5b0d7450de5f 100644
> >>> --- a/net/bridge/br_input.c
> >>> +++ b/net/bridge/br_input.c
> >>> @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_bu=
ff *skb)
> >>>        struct net_bridge_port *p =3D br_port_get_rcu(skb->dev);
> >>>        u16 vid =3D 0;
> >>>
> >>> +     if (unlikely(!p))
> >>> +             return;
> >>> +
> >>>        /* check if vlan is allowed, to avoid spoofing */
> >>>        if ((p->flags & BR_LEARNING) &&
> >>>            nbp_state_should_learn(p) &&
> >>
> >>
>

