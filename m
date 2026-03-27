Return-Path: <netdev+bounces-272366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDHGGJgAxmk/FAUAu9opvQ
	(envelope-from <netdev+bounces-272366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15033EFB2
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0E0B3039EC2
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EB374E47;
	Fri, 27 Mar 2026 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBWapoF7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AB371CE7
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583797; cv=pass; b=ftIyJi3y0jaT9g6HFrUX7Lft4yBUn/uqHJWsTr2qHqYIOtGxvCq70Mwcg9ybPKDu3skW5OsWHrXfVJLvFpuLqiKaw4aLFwIgK8Q886bBY+kOmucnbNloHPxN+qmW9kSt6x0XwCJX0FRd96kQoRlywmevqdrDVbKYrxy6R6coE3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583797; c=relaxed/simple;
	bh=ZHlsqyNZyawT03QriRhLGUs+mNs+NyMBe3mWgUrTbXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2SZ6621BL4sMaNcbkvQRqyThzGP79jxLpkwFR2R8jo+pl8XW8UYvsec2LXMQwduHYY3rAqlbTkuGxziSQqHrR7xVpwlP7OngaEThKt6SqhrlCR09VVG2ALZNOiI02G+PPqz6RFdBiXPX7MDFLj8Ye9B/R2fHETAR9n/6twGrrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBWapoF7; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so4447a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774583794; cv=none;
        d=google.com; s=arc-20240605;
        b=d0Ayq2QESMp4dG6Ns8QWE+t9gUYi+EqAFePqfm7Xr5r04I/gMIr1YlJbApmnVR+oA+
         y56F8uAExS11qGg9xiIjsX8IrdvtR++WlUDslqjXEMdAc9IH5K0x5eVvdASfV6OfcbbQ
         qQCBR235Uj3XBsoNiuT9mvHMfsXKxFJB01MkjHJJ7eYkXEKlQNtVuy3RGPI/6uG6k5zd
         gI0oSpW2y+XcH3fJGNccodmDUNRC/uGzGyAPfVDaCKUODr+6OLZZntHQkCvLIUGEqfe/
         u4WYll682+YE7dV6tMSLDdONQ65sq09Mb3FG3o7u0FdfVxp8krRBbcozzJku8QuAnzv7
         h/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rB86wEm472jC0EI7/sOjPjEkcgMkRJxcoDs7SFXkhWY=;
        fh=aNTGI9RDtxFjFE+feQCRW2Jtkw3yW6nhEl4r2Xy02Ug=;
        b=hmIbSWNNMsHHpJ+4kroC3np26MKb4xOQRDAhT5isOKJGR1n/A8L9l/40rRlbFngAVp
         Aj1oIKxXAvNkr3QmaoTorSP981c+epcYAln6wIJ7Ef2Q96iMDGTSbqhgo1IuMGyn5lph
         osUlUYbOsSHwkqURBPeLYDQnHHmncffwKDhIook8LZZccOkp62DSVNxHaJs7ihqUK1jQ
         HefqgZRZLgJqrnKRlZm+TEemsn5MY5Z2qHznOsW1mdlXjB8XmqMrHnDiY/wqqmyFcjgR
         QJoY4osoivqdwA5lIozUV89BmsQLTtwcH5/NiiJFWMFnwKSNlpayVggQr15zfWVJuirw
         52Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774583794; x=1775188594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB86wEm472jC0EI7/sOjPjEkcgMkRJxcoDs7SFXkhWY=;
        b=uBWapoF7Pev7mNa72IuqrpC/7O8nfjdoY/126DyryryRMs/tQH0RjMDFNDIO9duksX
         hwtonXyTZd/D9TTGzvmh1lVC9BiO4ZSvaJyihUXCf6bLNb2mWRRFRUiC3iEQ8730Z+Fa
         xgH+IpV6vrRZ7m37+Wnz2LbUOZOEYTnd/LN3u57LKJxGFmOD8uxMGp+c6eI+zCVofWjx
         YrgFRVONtcZdR+ITGqkkrY1HDxhaJSwnOWYUhD23JfcyavwFzI7rTAyPNTMj1/ULegW/
         EuGc39ONJlSFanQWHzOcA8lyOUOPsyl9yFT7zTT86JifLqGh2NOipsRwNAsU2lDLCxVi
         L01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583794; x=1775188594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rB86wEm472jC0EI7/sOjPjEkcgMkRJxcoDs7SFXkhWY=;
        b=U8WhkfsubWHrdtgjIL5ioyrKCAf49ZhArA1ihq0QwH9i1029S7WmCeIAI8PxzMvJqI
         20lztz0SQMmgKzyjtYfyDqQpSZhalgCNpsIrSrq8EVluCJS2AHwDx9tU/20LUUFfTD+U
         ywCVdCU1rWehbKSw8EC+NuUvJGLyvY6EeS2nb4nhmb3V0QhhDrYkRMgMGqDv83frzWSS
         TDNcR9De+dtWMiLflAUL/vTGuklNkm7gdBo4lBsn3NirjX1iU9YrLIZOwpfbbxcHBUc3
         2aLyrXKZGKDEf3N2ZsUOsxvx5+qoPPieWZWuQOmRrhWeJREEy0bxFbASmESeloVqHiC8
         FRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0lsV/MXK3vqP2CYW8eI4HJ/bM4Slece8/oysmXcFgSPbrrGZtbWufCJv4ITNAdEksI1CLrJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKMKBAU//+DWtqpvBBrieU7qlZdDxy10nVTkYnhfsRx4v6gSI
	LrfGdHsYYx99vSOCJ8Q/LVudyGo4QnAXhgCOFKXMvd8GICsRCRoMLdnNjgzi7qrovNyk/GFuEJR
	b0He5MBnNTJGkYQ9nLizJW/Pp7ThAvUwBHMjf/zaU
X-Gm-Gg: ATEYQzxx82g1lMdvYTA5/iWo2k6rWA+DubsfZr4UEkNH3pfbaBkXe5BFho3+Vn4pyrb
	pPKAykh5hpnok1wmqLxRJ7sv+tfwAkkzbDpvGRlAG50/naYmnatg2VuvbxcrimAjutHD+9nE5NJ
	Ykvv1TfLrJqDl2b5/eGJSDxlsH4tyW8NV2wfQl7NqB/RDlHoJK+HxXWLc5DG7DZOqq/DFWGEcKt
	qo+O5EhHPqbFKpfhxoTIli5H1qKQWMlHSrhh1acdHjfQ8BMdwadSEq97wAA+UEiLIkemeIAxOS6
	jSVI6S5I4BAcNgSOwmH+umFfl2u+fod+7DrG7zva
X-Received: by 2002:aa7:d51a:0:b0:660:b029:3d4c with SMTP id
 4fb4d7f45d1cf-66b19d0164emr33627a12.2.1774583793983; Thu, 26 Mar 2026
 20:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224527.1044097-1-hramamurthy@google.com>
 <20260326224527.1044097-2-hramamurthy@google.com> <d5312a24-68d5-49e3-9787-9a01c8606d9a@huawei.com>
In-Reply-To: <d5312a24-68d5-49e3-9787-9a01c8606d9a@huawei.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Thu, 26 Mar 2026 20:56:22 -0700
X-Gm-Features: AQROBzALp6QdCFE7EVqpj0HU36tZxtqzBPVOC8Ro06FQhRDzv4YHr12oJ2YyEPM
Message-ID: <CA+mzVtsXm1M4G_qiuEZ4A_ttJk4NL-DP-Ceo=nFPWRNUSn6RBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] gve: skip error logging for retryable
 AdminQ commands
To: Li Xiasong <lixiasong1@huawei.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jefrogers@google.com, alok.a.tiwari@oracle.com, 
	yyd@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272366-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org,huawei.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: AD15033EFB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Li, thank you very much for the review. The intent is only to skip
logging for *retryable* commands that return -EAGAIN. If a
non-retryable command fails, we do want to log, even if it returns
-EAGAIN.
Jordan


On Thu, Mar 26, 2026 at 7:28=E2=80=AFPM Li Xiasong <lixiasong1@huawei.com> =
wrote:
>
> Hi,
>
> On 3/27/2026 6:45 AM, Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > AdminQ commands may return -EAGAIN under certain transient conditions.
> > These commands are intended to be retried by the driver, so logging
> > a formal error to the system log is misleading and creates
> > unnecessary noise.
> >
> > Modify the logging logic to skip the error message when the result
> > is -EAGAIN.
> >
> > Reviewed-by: Joshua Washington <joshwash@google.com>
> > Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_adminq.c | 26 +++++++++++++++-----
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 08587bf40ed4..c7834614c5f0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -416,11 +416,6 @@ static bool gve_adminq_wait_for_cmd(struct gve_pri=
v *priv, u32 prod_cnt)
> >
> >  static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
> >  {
> > -     if (status !=3D GVE_ADMINQ_COMMAND_PASSED &&
> > -         status !=3D GVE_ADMINQ_COMMAND_UNSET) {
> > -             dev_err(&priv->pdev->dev, "AQ command failed with status =
%d\n", status);
> > -             priv->adminq_cmd_fail++;
> > -     }
> >       switch (status) {
> >       case GVE_ADMINQ_COMMAND_PASSED:
> >               return 0;
> > @@ -455,6 +450,16 @@ static int gve_adminq_parse_err(struct gve_priv *p=
riv, u32 status)
> >       }
> >  }
> >
> > +static bool gve_adminq_is_retryable(enum gve_adminq_opcodes opcode)
> > +{
> > +     switch (opcode) {
> > +     case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
> > +
> >  /* Flushes all AQ commands currently queued and waits for them to comp=
lete.
> >   * If there are failures, it will return the first error.
> >   */
> > @@ -482,9 +487,18 @@ static int gve_adminq_kick_and_wait(struct gve_pri=
v *priv)
> >               cmd =3D &priv->adminq[i & priv->adminq_mask];
> >               status =3D be32_to_cpu(READ_ONCE(cmd->status));
> >               err =3D gve_adminq_parse_err(priv, status);
> > -             if (err)
> > +             if (err) {
> > +                     enum gve_adminq_opcodes opcode =3D
> > +                             be32_to_cpu(READ_ONCE(cmd->opcode));
> > +                     priv->adminq_cmd_fail++;
> > +                     if (!gve_adminq_is_retryable(opcode) || err !=3D =
-EAGAIN)
>
> In gve_adminq_kick_and_wait(), the condition is:
>
>         if (!gve_adminq_is_retryable(opcode) || err !=3D -EAGAIN)
>                 dev_err_ratelimited(...);
>
> Based on the commit log, the goal is to skip logging when the result is
> -EAGAIN for transient conditions. However, when gve_adminq_is_retryable()
> returns false (e.g., GVE_ADMINQ_COMMAND_ERROR_ABORTED), even if err is
> -EAGAIN, the condition evaluates to true and the error would still be log=
ged.
>
> Would it be more appropriate to use && instead of || here?
>
>         if (!gve_adminq_is_retryable(opcode) && err !=3D -EAGAIN)
>
> I may be missing something, so please let me know if I've misunderstood.
>
> > +                             dev_err_ratelimited(&priv->pdev->dev,
> > +                                                 "AQ command %d failed=
 with status %d\n",
> > +                                                 opcode, status);
> > +
> >                       // Return the first error if we failed.
> >                       return err;
> > +             }
> >       }
> >
> >       return 0;
>
> Best regards,
> Li Xiasong

