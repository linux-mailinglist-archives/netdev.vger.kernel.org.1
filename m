Return-Path: <netdev+bounces-292461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBPPBdtnF2oZEAgAu9opvQ
	(envelope-from <netdev+bounces-292461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:53:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532A5EA7B8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E606D3043588
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9A3890F3;
	Wed, 27 May 2026 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo2C/cBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4820341AD6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918806; cv=pass; b=KvzmPftOQVlApHJRcqlJd1J8DvgemaqG4xTBiYcXxN2LzfaWrV96wlWQSnqK2lfjF8k1cWL0/FBX++t+FCNXm8jyjl6+RYWyw2dU1QJKKf4+3qbqDvViWLTmuJthAbZdSZTCWNzI6h+MW/fBe12ICaz4or3hFh/rHRqIjIhUow0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918806; c=relaxed/simple;
	bh=obIePSmQ9StIZWujUqwDhIiigBKuprK6vbC2wRCvt28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6aR4aQfMqA1Y41ZgZT7QcdKnKd9FaZU40HfITmDcGmbhQbNfQJiTlxtV1nYH5idK2iRk37apkuAtPPojgBPzxR8+6Vn6kbB6hPsKPGCOFlnUfr3kUJrN1fYj+ycpVzpZ3T7zdYEcoMUwc42DH2SV7H2xmG2Tr0Nvm4WPtZeKEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo2C/cBA; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-836ebdeb969so5442712b3a.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779918804; cv=none;
        d=google.com; s=arc-20240605;
        b=KIBoqfJUcSZx2Glx9Os2ryv/y/g/quO4JyH5BtWlZEOpiIqeXiUFbjvqd6mJBuaZnP
         az79PjAeP88ExsKRyYgpuVRPcjiPwjdz9wtsVwY793bOMc+yBs0re17y6aeffIckTCNc
         2aXu22fCPWPgykmk7i7kPsk9lNUY66IkcpOY57f74jSt91YMa9h3uG/pa4c+1lNgmupg
         13WV85agFY67Nmaa8B8Yqaxja7LgvIep9T7lZolg5am+LyNldf3xzhx+nodyppfBN9KT
         vL+UrYLb3JbJNnhH+IAA095ZLJAaLRMQtgQfgVjkFAyldasb6/QX54rathyMIWSb5gic
         dOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GyNTDCBxdTK2oUXaYmqMZNuIzrPaxBPOLpkTXgfkXYc=;
        fh=Kfd/SWnWGFXZnBC6im0dHpmenzIAgrPs3nGF4zyNkPo=;
        b=OLXoDXSNjDrKp2VOA17Q4xZ1KSfNMB5yKemo/7iMUwsNKzV4reC+uzLKNYzskV3HRu
         KNZQxAXmZhOUOK7xeXa8KQrIh1toenl5bakE2hKKpAAzpBtCulLnJZd8/eaSAAqa2BM0
         LynJWzaR0pp4+YIpLkBB2F+ID+DVNlOrgVFZKPf4oxGv+4eWqAtbjJj+PGg3j+cFPeXO
         9OvM3QfIEPaagciG4gWF6/8Pwx87BN8TrohAlPyGSRDOfcoplubq3/fmlNT822gqVhzJ
         6qj+k3Kbbs76rzEQTKAH5+9AeZ3bkPvTs+HKbpQDrrH9K+wqCTM/xDTUBI09OXWW5o3A
         LZMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779918804; x=1780523604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyNTDCBxdTK2oUXaYmqMZNuIzrPaxBPOLpkTXgfkXYc=;
        b=Lo2C/cBAY1Mr1ZkN6eNmj/xZcsbyrgB76K3BlhmpSDkGjnOhZb0TxLncPKamUeyHC0
         gAyqKIkoysRvPeeP0G5X7sb6py41u71aXFWAbAO6vPr+V8LInb4gWFiREHyOb+OF8bvv
         N3SSi9QDSEU2f0itWkn61jOB77wPVR2mYesSP+d9H5Y0xmgohegNaU/Ep4FPLo4J4xXl
         GaafplarmdJOKG/1yjZ854FZt+4JW7gYo8yVLt4v2O/nuiu0KAwqIQSaNzjGi41oEb6v
         BjP49rnhkNW0m2UEpQ1nz/GjwpDWFlhjomwd234EUJrQ/cFnVMImGYQGsPu1pNMjF9+2
         IwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779918804; x=1780523604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GyNTDCBxdTK2oUXaYmqMZNuIzrPaxBPOLpkTXgfkXYc=;
        b=VCHobam3Uhr8ZrJT55LUzL5WP1bumFtkLmSvpD9AsNPqb+BuUucDug548zAokIY4hV
         wSwkkU5NRmKDoQ8p5FuDtuukNUbeD6mxAn8nHzdXO6upgBrTak4qjjWd0EcrxLmuk138
         HvLIv/5/K5+maq1SrTFy71Z6nhgAK5NovS9jzVoIyR++dQQX7JZGiNOfpOoyuVaoe4jW
         k2vgAVAi56Q15G7UYPmQ90cyC9iXcXilnEDZzkRxkdeWM754C8QlQ8TnBKrram6baher
         aj5tZf+akE77EhQaaa3/oxxk5PKRymp4TCkpFzceepBHHBn02osIhKCLpwZjnUgsAFmk
         KckA==
X-Forwarded-Encrypted: i=1; AFNElJ83sMLS2Mez03wsfHagrqIttvfSkqYFJB2/olHGAdwJ0DrGCC3yUtI3lwJ58fbIuC3SdhkSZXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzW5c0wY3ShQvJRMVq9X3R0TitCGmzjJmf0NrSHlWWeV94PkHU
	j3IslEa3LuoRPnnxRxsP6lSEZjwQu7mkn/OxqPRUUJPmkJRtWW1RQEs79xyHDkWXxwsuXjX7YXX
	lryyCkU4ilvPIP1VAWmL9B91wiXLc+Rc=
X-Gm-Gg: Acq92OHnbE1uh8QgYDOHnhw3UM8ca8Rx2Q05ZpgfdSGeOrusvSdCJxZd3AsC12Yhi+w
	abPgAofVkGdQtKcM2Aa6oWkEccK9VZ8Yt1MO9MFX3R/SmGx928omIGGw4yH5Z+wZJ8AdgPgq0KV
	44Myxm6yMG8fhfJXvIMrQplquowSyTAQshOfNmay8kFSyrHlTkX4rMB1PvzGh6hoba6kHef8By8
	xGu8OngkVy6SnmuGKX0oqH5Y6ed40B0QpEUh4bASlIgjYxDtJ9KYcvTsoOdTRduKJldYrkpe5tM
	2pYfxglSyzr2Z4Xmw0HJnNN81vraelgoywroIzsS0C9g1xp3Z6tORB5fMn1iL6kibXEq25zCsW5
	0M0ryauttwTK/lri41A0Uvrbnw9DxRGWwne9VUN2UJkoSKShZWQ==
X-Received: by 2002:a05:6a00:849:b0:83e:f228:b112 with SMTP id
 d2e1a72fcca58-8415f3799aemr23326619b3a.34.1779918804159; Wed, 27 May 2026
 14:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779635498.git.xuyq21@lenovo.com> <8049cf6a7d4e62a002397cf289c09ff373b19f7f.1779635498.git.xuyq21@lenovo.com>
In-Reply-To: <8049cf6a7d4e62a002397cf289c09ff373b19f7f.1779635498.git.xuyq21@lenovo.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 27 May 2026 17:53:12 -0400
X-Gm-Features: AVHnY4JMhqox-4neS28F9_X8UrzmgVKL_rnpOYljH4l3vwJK6pLIZcZmI2V-q-s
Message-ID: <CADvbK_eOSCO6760yYbSVyn7eCo5a78jMjMomocbR+z4Nqcd=6g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: stream: rebind out_curr when updating streams
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, xuyq21@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292461-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,lenovo.com:email]
X-Rspamd-Queue-Id: 8532A5EA7B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:28=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Yuqi Xu <xuyq21@lenovo.com>
>
> sctp_stream_update() replaces the outbound stream table while
> out_curr may still point to the current stream selected for an
> unfinished fragmented message.
>
> Remember the current stream id before freeing the old table and
> rebind out_curr after the new table is installed. If that stream
> no longer exists, clear the cached pointer instead.
>
> This keeps the scheduler cursor valid across stream table
> replacement without losing the current stream when it still
> survives the update.
>
> Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/stream.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..fcb6c688f61d 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -208,6 +208,16 @@ void sctp_stream_clear(struct sctp_stream *stream)
>  void sctp_stream_update(struct sctp_stream *stream, struct sctp_stream *=
new)
>  {
>         const struct sctp_sched_ops *sched =3D sctp_sched_ops_from_stream=
(stream);
> +       __u16 sid =3D SCTP_MAX_STREAM;
> +
> +       /* Preserve the current stream if its sid survives the table swap=
. */
> +       if (stream->out_curr) {
> +               for (sid =3D 0; sid < stream->outcnt; sid++)
> +                       if (SCTP_SO(stream, sid) =3D=3D stream->out_curr)
> +                               break;
> +               if (sid =3D=3D stream->outcnt)
> +                       sid =3D SCTP_MAX_STREAM;
> +       }
>
>         sched->unsched_all(stream);
>         sctp_stream_outq_migrate(stream, new, new->outcnt);
> @@ -217,6 +227,7 @@ void sctp_stream_update(struct sctp_stream *stream, s=
truct sctp_stream *new)
>         stream->in  =3D new->in;
>         stream->outcnt =3D new->outcnt;
>         stream->incnt  =3D new->incnt;
> +       stream->out_curr =3D sid < stream->outcnt ? SCTP_SO(stream, sid) =
: NULL;
>
>         sched->sched_all(stream);
>
Thanks for the report and patch.

sctp_stream_update() is only called in COOKIE_WAIT state, where
stream->out_curr is expected to be NULL, since no user data should have
been sent at or before this state unless the state transitioned backward.

However, there is a corner case in sctp_sf_do_5_2_6_stale(): when a Stale
Cookie ERROR is received, the association may move from COOKIE_ECHOED back
to COOKIE_WAIT. If data was already bundled with COOKIE-ECHO to send out,
this issue can be triggered.

Updating stream->out_curr here is not a proper fix here, as any transmitted
data would also remain in the retransmit queue.

Since this restarts the handshake, negotiated parameters may change, so
previously queued/sent data should be dropped.

So you can fix it by purging the outqueue in sctp_sf_do_5_2_6_stale() like:

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 8e89a870780c..9b23c11cbb9e 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2598,11 +2598,7 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
         */
        sctp_add_cmd_sf(commands, SCTP_CMD_DEL_NON_PRIMARY, SCTP_NULL());

-       /* If we've sent any data bundled with COOKIE-ECHO we will need to
-        * resend
-        */
-       sctp_add_cmd_sf(commands, SCTP_CMD_T1_RETRAN,
-                       SCTP_TRANSPORT(asoc->peer.primary_path));
+       sctp_add_cmd_sf(commands, SCTP_CMD_PURGE_OUTQUEUE, SCTP_NULL());

        /* Cast away the const modifier, as we want to just
         * rerun it through as a sideffect.

The userspace would rely on SCTP_SEND_FAILED_EVENT to get notified.

Thanks.

