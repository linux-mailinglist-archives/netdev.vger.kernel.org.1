Return-Path: <netdev+bounces-275227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBaQEzAx0Gke4gYAu9opvQ
	(envelope-from <netdev+bounces-275227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0AE398731
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BD553007BAC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBB3D813D;
	Fri,  3 Apr 2026 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igGcSdME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3673D6CD3
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775251758; cv=pass; b=POiNNdl8PsClrSAZRtaAAM6xCXW33ne0qMh90bjyyF4fxlksUQglSm1jDVtha7bjYag0knlaqtWA4FMRIKJEIl6WvFAOZ4Om3A3FRp9NFCSDkDYGwitc8f9fgELSzgQmFEky2wuqQd2QOalqCEUUNRx6XXHnVZ8/f4xVq2laz3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775251758; c=relaxed/simple;
	bh=gsH/k1YmLUDqYHHjwfnJDKGrZD3y/4U1bTGRNG66Lx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCyjXbyqzgahpnqLUuNzsL3iacMcStAxwzBA8lTCeUCnY1ZedypHiVE+1I1+u+MkD5tVXWpKNR8xNpDml2Av2zF5HhPRTyJpoHBCszlnqJT6OIdhceI5kxovITw2bvgmChp6f0wPgT8QK3NSD55/fj3UlnOIY+AxL9LU/yzDp9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igGcSdME; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so10917a12.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775251755; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/EeV/2mSmlcxXeIzUTVK3E8nWQCqJSI+/2bfVdeNOpX3+INbCE097bkbXmo0rLmct
         NTrnVCMNBiGevadHFnOrrFuKQphRoQ2e6UF0v9C+t83+9sAdyjfsmgMVkmNlMS9XPnNE
         lJHjCBpSfMSrSV3AKvWdJUDuAa04kUOBVPz1zyQLWKnhDgmcrKx6dK0rFPkQcGaAJmzB
         txeSObvQydlW0HsBdMZJiMn3tujBFsSZn0oCVPI0FaVrAQVTCmsGKb2N1Z1au0vvs9cw
         Nlz13I/6YZGZXQgTOHWZZ5waBR5Q/PicpS1RRw8/ICXTRhv+CQEahlxscvAOa4+5/sE9
         ZjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AfK028ui3l2rIFTfaW+K44Xndf/avRg8lxni+V1HpyE=;
        fh=8FfTFibQEfCoOLJcOj8tDX4VQgvd+ng77rweSLOtQi0=;
        b=Qs8aMOnGpwVJgtHFjIiBiB8SYeg3NfvueU7GYfEK47a6k3I2Pz3ivBJJ9p/ZCqE3Qp
         /NM87fhOjkt9LB2GPoJh6ibTDHOizwRBKZWQ3WgGu6t4jOTMZwW9toxw2JGJBzsPpweY
         5Yp62roRS2UYSVWULYOda6UMyt28C6UaKB2JjMNlc2DHAUlBrpEm2Ww0esp2xQ8wWT87
         XpiEALVWdxbhI83aHlbCbnoDAGR2vxzobQi0x0Hy4Ct9vNWSN9uU5SpSe+5dFAlLMeGu
         Txik/D+FkHSpEtSeHdkvpSb+0o7x2g85qLhruPA51XkU9VT+wTo1D7XQIw6KJTtmsb96
         YJHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775251755; x=1775856555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfK028ui3l2rIFTfaW+K44Xndf/avRg8lxni+V1HpyE=;
        b=igGcSdMEJCJ9g8YEWtxzLPubLKbMbewu6RKq+yvEKoXoPOhu2LqCFwfGS1AIUhjlIC
         TRXzmM55eP+N2zy+fzkdmCcDzg1wlQrSFbfb8NDvnhgmJQrgRn9L3TbWWGUzNZ7YUvLR
         4kSi2zTnBFOYjDoKnKRnlHlkOK87sJkwh/6UUh3YLxG/4DSNlV6XCuZk3Lku0DzctUbo
         iw6QsZwQPu/rx6CUA+CUQzP0OhNWjYahUyMbmOGG664yZEdkO5KWEoB4vhDa31i9tmEi
         qkziAR/T2bdN8yRklRa3EvMyq4Vo5X21GacvwjX8fIBylld/KB+3Ks7aFXlT3FUEsnkv
         OijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775251755; x=1775856555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AfK028ui3l2rIFTfaW+K44Xndf/avRg8lxni+V1HpyE=;
        b=eN1xShkFRsJ8+BLIridryjGMAIdzrhWHkcT+hcgnT0WSf+Q3MkB9cIVdJ29aZMs/W3
         QQAkN/2evlA7pjpeTgHmvHvmic8YREfSAmXmzBIo3Xt1FoPxeY7eVDdaC9HiyKbdWfMA
         uW9BfkXbkPrV8IgEUg0FULJhX/+5pJwqMZVVZju1kYOISSvsVO9vIyiRJS6cjSMJs3V0
         Qc4u6EXgomarvnTMlTYZu2lEM/pLff0R9za6JXO8wjkB9OVvLGW1jNSVtbdmBoS7kRFo
         30OPGWoQnZho3f7hen4bBjzB72CKpTQSgeUmo99yXZERt6wO0ytJ+u2q/WHaEdbJXgUj
         TbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuGNfiYGFhmGs4jOqtHVykqs4IcXUQSVmJA7T1Yyp6FN9Bi2Mz0Z/QIWNH4pLKU8FbuvkT8dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbHuqAW7FBdrMX3KieBlJnFPjYaWIeJPKbvOK1GDbKd04ych8
	6VCR3mEku1ZpL9o8//UBNmo9MWiaU5xM2jiTNciXFPpAjOh8NBZjVB2PUL5iT1QnxwLPb9i/2ru
	wMhNQwcDyKO0ijGYh30HVwldGuot1GUVzEgES50Dq
X-Gm-Gg: AeBDiet1umjOKcmjkCxTsFKHoE3nWrGHbB7CzbNuHCog6yWqDmhC7aDvt2S0y91T7r+
	d7saml/ogYbVoD2ivUTGODzRDTf27sy0iTjexiiDO+Ektx33i8QMjrm0ptNyp4NAd/fMJ8DBlxJ
	1kUujCjhoqWhdSw1c69iTqAvJtgPhOkOTnhktaWIiM3TxWw07UIEhnSdMZtsCZ/scyNT/Y7siXw
	Ixwr/Et9dfr8lbXeMh4VJpvxltRjKhkOFiyPWlSqZKNFasTVf1SZ9YTfqgHVMH3feEpelIzbXzz
	UG0FmxxZAgMaqpnso3tNmOkd2esfHpa2DxedaQ==
X-Received: by 2002:a05:6402:20d5:10b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-66e432e10demr30414a12.10.1775251754589; Fri, 03 Apr 2026
 14:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194427.1830609-1-hramamurthy@google.com>
 <20260403194427.1830609-2-hramamurthy@google.com> <1e3a815e-4fdf-4bf4-b298-42abeed67fcf@intel.com>
In-Reply-To: <1e3a815e-4fdf-4bf4-b298-42abeed67fcf@intel.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Fri, 3 Apr 2026 14:29:03 -0700
X-Gm-Features: AQROBzDDT1JovQYphS2L3IdaBYQXkAv_7RAa2EH3W5nvqNQSwsRzVfLGxd8jv_c
Message-ID: <CA+mzVtvhcN8oDVOwruwesMkwsDovN1eU693bbhfFTs-e+0gSTw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] gve: skip error logging for retryable
 AdminQ commands
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, thostet@google.com, 
	jefrogers@google.com, alok.a.tiwari@oracle.com, yyd@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275227-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE0AE398731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 2:11=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 4/3/2026 12:44 PM, Harshitha Ramamurthy wrote:
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
>
> The implementation changes from using dev_err() to using
> dev_err_ratelimited(). IMO that is a good change but it would be nice if
> this was mentioned in the commit message.

Ack, will do.

>
> Thanks,
> Jake
>
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
>
> You also now log every error regardless of what the status is since this
> is no longer checked?

PASSED gets translated to err=3D0, so it will not be printed.

You bring up a good point that GVE_ADMINQ_COMMAND_UNSET will now
result in two messages being printed:
     dev_err(&priv->pdev->dev, "parse_aq_err: err and status both
unset, this should not be possible.\n");
     dev_err_ratelimited(&priv->pdev->dev, "AQ command %d failed with
status %d\n", opcode, status);

The first message doesn't make sense anymore, so I'll remove it.
Thanks for catching this.

>
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

