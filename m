Return-Path: <netdev+bounces-294833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wYmbDEVWIGqs1QAAu9opvQ
	(envelope-from <netdev+bounces-294833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:28:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 958EE639B94
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:28:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LverCq/b";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44BB430471CE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E93E123E;
	Wed,  3 Jun 2026 16:17:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C23D9028
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 16:17:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503459; cv=pass; b=cwge+iGegaylDB/09URMHcYT6t4i7qw3GbnFrOu0llwJ7vnczVhI0+oFBGqf4lGWnvpFjeOqV3n7+YP7hV3qUSYjWJeJJ7x/0vnkwg3o4MMA5Q58IGF+ey0KNWTFxjOPuiYLsKpPEFDLaftGqBvCPIdJmu3u9yfCgbkCXs3hkYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503459; c=relaxed/simple;
	bh=35yTCGZEFh5BBZx7RUwjJAduTUoa5mA8xziqKGSWw0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LasSwQ54XwcJ3d4cmw8z5XylpU1JtGN8GxTZc83VBf2BF6Pi1XTwgxfSvdJqPTrOCLHisYqdB5nvB+wXXbGzhUK4FI0cts6SpI1XZmMAbAEi3YecWPbVDDeAQR9A3JT9A8ZJH3FuI/PrrRbXxGQCNjiM8ASRBnYF6jcjo0WrnzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LverCq/b; arc=pass smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8585c51f1fso442136a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 09:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780503455; cv=none;
        d=google.com; s=arc-20240605;
        b=j+4sHTv3wQeCDRO3vl8TE8PtC1vP3ue98KwBbQ2F7o2eLJWOp+mF/M9Z6KxAmii5hr
         rBRqdNeAKwXbejmkuoddzSXhVFw4CzdCkalcSnGk02S3R9WOQ2dHbLd/Ub+PRaWZgmMY
         aKJDYQaf8cbxdElAqYAW6jO1hCJwAT0Hf9J/KSV17NnkeI8/WZ0bZeU2jSRtVXTeSQfY
         yxNW4B73sB+ocsGkG0x0iFqJ/DAHz8jHgorY8sUy6jDGFhStL2pc0lKHHZpQUiL0n8yD
         JrHqZLwjMf48+QrMRpm+k7gvmFuDnMTaxi+jWAvORE3N9UlXL49lW0YgPy1cALRfIF7+
         ejiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wf0teoBvvQIcbnBkQqQlc7GnVBu3/kxy8sYSpzsvuqs=;
        fh=AU53N/lh2ThINFxnM8MLlVEZfqMHIKPUpfea3/aRhGI=;
        b=TNnzo1tgFRFq2UdWQ+whFNfVCEwYNNguYVmSRERdfcOqI95xCoOl2jKnHDz0CP8JuY
         fAoAgjOgpwv5ffwj8oRV85Foq7+iszBxtg5M00fmtSX0HnvdHgqwDarvncZETcf+QLMe
         3Uo/j6lEVMtR6lRTm0lHvkWkuiUIsG9VqCl/Z2LfDZdo9LeuCH7dJeD2zmimeRowRbte
         M6J01c7y49mDnVC9HTVzT/Zc3sdMohXpkXUHL5TbMA1I+EnTdT00pWof7nWvrfzDqp3L
         aeczQZFc+GgChrd00K9BQz42LRqLaaXNp8W72czk90Ey9x622ZOsHIj1eU1D2nqbQee4
         Y01Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503455; x=1781108255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf0teoBvvQIcbnBkQqQlc7GnVBu3/kxy8sYSpzsvuqs=;
        b=LverCq/ba/TiYxOIzRGykO3gBBKFUs0t2sCA8JHGH8xPBWvYZBy4holKGF1mVgP3nM
         hsWJE/fDDibA/JWEae9N9l2UB5rgZIQlDuj7eaTjUKCIsdbLQnuaGw/nVHtbYDNLR25j
         NnfF431tTOYtKKt7NTp3r6qMzVZWYFr4rPF9mScMehnIXyLrVfYCzviUcPgFZgaOLT1g
         qCmVpqLLAO996SlVgx99AZsmV0GRO8nphGjF0eLVaxEAST4BDy4Gq+g3JMvLn2z9S5Qk
         U/srV5CGS1re1tpOi9/0rdR06Ltu654i0CN8X10FfJoj44a3BOxnSC8dZDs7Iwz85ao5
         elDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503455; x=1781108255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wf0teoBvvQIcbnBkQqQlc7GnVBu3/kxy8sYSpzsvuqs=;
        b=cN/f1tOG9q3yJ7Zp+r0BmdU8wMrZp0UYEvutRdFW4mA68zEB/G8jEfsAu3EOKGt2HE
         8vtr6cIKg0/XFSRfHHWvR39nRifpKQB/1gosjpy/IG/kV1UmRva7hku9HPrR6TEUcvKD
         7q5koWEeWkqaTIWUMZJdEJOMJ1FW9xRQqT8rXwCXaIe2sB7SG0IT64qWmpABlA/3o/Di
         D2fuoUZ/eUTffKEcC15ZBHl6p03UVJW9kI4PWfoHVa8OcrklR3ICtmYiiD/Z5xIiRDLb
         khiC1mm//KZUZw8ytyDmnJ1YDqADbOLeNrD6PusE+/Ei3D3H79M8CMlYwjsIliPgmVX0
         Ui6w==
X-Forwarded-Encrypted: i=1; AFNElJ9CCQGXOiMbhN6vW631J6a6RWvAYsdz9yrLBUEl5EPmmjiSEfoLFlobKEtx12UgUKKOi+WSBsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/1W2j5IHtD9dvgyubM+PjaRCmSfeMPv6sAexSd1XMbetmEfP
	PzbVKtPeGUedPBlXGEHvX55YwA6SKKX4LoufE+4CsGNFdibGPfw4Zi3mK4iesxqNG7idr0xRbYp
	G/ABOti74h6kvwD4+Qy9gJBX50nhHAJQ=
X-Gm-Gg: Acq92OHuK4bZUzeSn2xbGm9n6hdeKe8iET/3G5t2If9VIdQzzJKlWaZ3hFWyQpM/G7v
	JCDOsOb2xJxKtZOBda9XqJMCdpi7Yy8FGDpjFa+RsV+R9gy7HSJ3rXhCn9PY66KjlXPyxYk2Ptb
	mIZXrXyFfCyEYVzbznZtIbquHRGNTe01ociMUf041Rhia4xXeyw3vP5+kiDUZWGlGpteSuX50Ma
	YjLVSfXm2grOmQFrfadf69VUWP5TTKE+eKX+/+JVseeLw/1v02jcZvqx6/ns/ayOFMmi7Wf22i2
	vVEJJP8JCDiLd0LKm+YRNy0ATMdnybO8KLGTTKQgnS/OS3legq5V1/E8lGKXS9el9OkZvYFJflg
	7in/GR1Nz/cKVxwSpWDCHTjUiTmKIvmww+osyltbn4Yu7/zk8PQ==
X-Received: by 2002:a05:6a21:150d:b0:3a2:edff:2975 with SMTP id
 adf61e73a8af0-3b4b202f8bemr43887637.25.1780503455283; Wed, 03 Jun 2026
 09:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780439824.git.bronzed_45_vested@icloud.com> <345886be48a66f70bad26ddcea6defb38d1d0f72.1780439824.git.bronzed_45_vested@icloud.com>
In-Reply-To: <345886be48a66f70bad26ddcea6defb38d1d0f72.1780439824.git.bronzed_45_vested@icloud.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 3 Jun 2026 12:17:23 -0400
X-Gm-Features: AVHnY4Lrb5hiDfvSo-lr3zrQ1yMaEYReNJTNcwgGKfGsajNvGcR_KgeT5FjHhYg
Message-ID: <CADvbK_fBqxVE+-ruaaYXsJY9L1TpchJrcLmhq-sBchAQTVZB_g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: stream: fully roll back denied add-stream state
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294833-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,icloud.com];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,icloud.com:email,lzu.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 958EE639B94

On Wed, Jun 3, 2026 at 6:19=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> When ADD_OUT_STREAMS is denied, SCTP only shrinks the queued chunks and
> then lowers outcnt. That leaves removed stream metadata behind, so a
> later re-add can reuse a stale ext and hit a null-pointer dereference in
> the scheduler get path.
>
> Fix the rollback by tearing down the removed stream state the same way
> other stream resizes do. Unschedule the current scheduler state, clear
> out_curr if it still points at a removed stream, drop the removed stream
> ext state with sctp_stream_outq_migrate(), and then reschedule the
> remaining streams.
>
> This keeps scheduler-private RR/FC/PRIO lists consistent while fully
> rolling back denied outgoing stream additions.
>
> Fixes: 637784ade221 ("sctp: introduce priority based stream scheduler")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/stream.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..5c07c6148228 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -1037,6 +1037,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                 *evp =3D sctp_ulpevent_make_assoc_reset_event(asoc, flags=
,
>                         stsn, rtsn, GFP_ATOMIC);
>         } else if (req->type =3D=3D SCTP_PARAM_RESET_ADD_OUT_STREAMS) {
> +               const struct sctp_sched_ops *sched;
>                 struct sctp_strreset_addstrm *addstrm;
Thanks for the patch.

Please move 'sched' below 'addstrm' to follow the reverse Christmas tree
declaration style.

>                 __u16 number;
>
> @@ -1048,7 +1049,16 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                         for (i =3D number; i < stream->outcnt; i++)
>                                 SCTP_SO(stream, i)->state =3D SCTP_STREAM=
_OPEN;
>                 } else {
> -                       sctp_stream_shrink_out(stream, number);
> +                       sched =3D sctp_sched_ops_from_stream(stream);
> +                       sched->unsched_all(stream);
> +                       if (stream->out_curr)
> +                               for (i =3D number; i < stream->outcnt; i+=
+)
> +                                       if (stream->out_curr =3D=3D SCTP_=
SO(stream, i)) {
> +                                               stream->out_curr =3D NULL=
;
> +                                               break;
> +                                       }
I don=E2=80=99t think we need to update stream->out_curr here since it shou=
ld never
end up pointing to a closed stream.

out_curr is only set in sctp_sched_dequeue_done(), and the stream_state =3D=
=3D
SCTP_STREAM_CLOSED check in sctp_outq_flush_data() already prevents it from
being assigned to a closed stream.

If the concern is the assignment in the sctp_chunk_abandoned() path, you
could just move the stream_state =3D=3D SCTP_STREAM_CLOSED check above that=
 to
make the intent clearer in sctp_outq_flush_data().

Thanks.

> +                       sctp_stream_outq_migrate(stream, NULL, number);
> +                       sched->sched_all(stream);
>                         stream->outcnt =3D number;
>                 }
>
> --
> 2.43.7
>

