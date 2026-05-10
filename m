Return-Path: <netdev+bounces-286234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEooI1QKAGqaCAEAu9opvQ
	(envelope-from <netdev+bounces-286234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 06:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5929502911
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 06:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900A63007340
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 04:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153272BE02A;
	Sun, 10 May 2026 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YadK3AXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FF279DB6
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387504; cv=pass; b=qerCL4f2Yn6U3Kio0/qHgcr0cJy1BhqLmvQNqEqoehsm+hMvBY+QqpY9c82JZ8DMl5l9kEtE8bNwIMvt0S84DJHfKs6f13QGTyhQp0JxBFi4SPhKnvZwlHMwHdAQCJsQqis+Yynk0MHpSvCEvuSD5E8cwZKPWX4AJ3JmxFNguhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387504; c=relaxed/simple;
	bh=rIJ//kQoovYdM/IAV1ULvhtqgWWu/x+bVqzk9gaZ6Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akWVhv69QHfpCZNMqZd1s5kC24DNiPCmsXYE9VtJTzk6ZJ+1SWmvYlC4cyXm5zw7fhIds5Lox7I6atuVc65zZsLXZymDVUVt/Z5hlGRVh+xypdqOky39MnM+4vnw171nr1kMogpR+tpa6L0w37ddy/bWZVO6jn7lGe5v7VZzoFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YadK3AXt; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso35a12.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 21:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778387500; cv=none;
        d=google.com; s=arc-20240605;
        b=NXbcJmlqKe80cTT71Lj7fxURlZcRHNwlboJS9Xb3ZTawx9Qn9thB7BIo7zEBrMadb1
         qetNuhFPfRUWilFeF0dV3mrH6w6UfM5NDP1t0jevkxZ3cWxFhlQ5+7H2CsCfLErMPQen
         2dKkTbkxU5pH0MwhOvz3fk4Tq//4x5zsRgwVQekC8Y1u4zSO3gbmaazwwLisnYaWd2lu
         Vt7ZLxprk6cnvDi6gMZweuo0PVmWKUTl2Uo1P3mjBUqsJBc86LSp1rANMwtDqBY7Z9QN
         G9F7Qqm51713gjKDNXguQSFNIAWrrf9s6HnNtS0xPj9O1CyXq7/QgMi/PB209iTLZwlV
         d1Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=toJCyJ6fW+FjGcx1go9QkGhEvAgKaSZORI0vHhe3BnQ=;
        fh=7G37HgrlOfvmM8wNE5sJt6luyR8ut5480h0+y19KSgM=;
        b=OqbUrX1Ypje1FLOsz5zgsOGEIpZ+YpEZ/5Xnl6J9QY6BSi3AHKd2z+ql/WoxqRyEJr
         MBjVh23ehJC9xDuPUsTt/FF5EDy2UHmsk0CW88KGcSweEg4QuSdcZcyT3JAa9kEhhF9o
         yDpEyuGNqAl4/1l+BYficw0+Kd90cdCuaYH9hWU+c64ZcNuXz480BcM/E3VSz0JMaFym
         PcoCiLA+gSG1owJKPkiPno+IuGLPgranobdwlIWqn24CCYSBKQ91iTc9Nmdld60fLNGP
         cax84yWFsWvbC2fmhrm2WsHAIPvs42P7h1YpwFkSRHGLhsrvB13OKAg1mhHRgkZahqJ0
         RDtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778387500; x=1778992300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toJCyJ6fW+FjGcx1go9QkGhEvAgKaSZORI0vHhe3BnQ=;
        b=YadK3AXtQB8UTg2WbblpChUh3T2jyqPf/AfNEeZq5jNVw+1WupRyF2VxEWMy2J3cRA
         nR/M5MTmsO6Gj3e4zToGdW5HPAMpT7ibj4xs1K1zRdmmpimX151gYzoWRMaVQyFEtOFX
         4imODM8dn8sA9vgPH1DJtqfvp32StThTKETNoyLqUFUJDDshCcbMnWMG5F1Mu5qB94Kf
         y/D6cVhy8prAAp6vsyZ230UDcwRMPcJwZg8dN+TLDEfziNQLAFFjySHbDvicqTdqOdLM
         /qKU+F1ZjVHATQwtccCNWq3kDphxa/HGBTG3UiaVMttL7EBOVGGdISJ/ydMy1aqPpvxD
         /+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387500; x=1778992300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toJCyJ6fW+FjGcx1go9QkGhEvAgKaSZORI0vHhe3BnQ=;
        b=XbrXb1Vh3VnRU/BRIymL7lPJD5ONQhKv/47hz+V/7Y0trRHh8C/kmQ7CP6g6CbiO5W
         sPnz+hGgO2l83VV/6RgQunHOaOdH3FXmX+WaBl9DXjbwY7WKHz+jFwerUfWVbiHot5Fc
         R+SCafarW3b6rzj++2PuGudtvJmF1pJSXAWmAy3XoDEsCnaq+HOpHohOeeKbEw8s9EUF
         jUcANitw8Kn855RX87MiizaqWtsovP8DMsi5g1RCN89nBg7y2J9BzAASSLlN3vPK8yTp
         J/MsNsIMANRybNvVgKqG2sQdUDuN0AVlaFBhZ2k2taNTTew6+XECcmLK1uudz/2jbzxI
         381Q==
X-Forwarded-Encrypted: i=1; AFNElJ/LJNj+bkx8HND+leRp8r++woX9fJ/ImKn3UM1j2HV+gftCPLnzNCnC3FNDidNEBeJXE4ts7Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHssXIjHiuWxdgAkGhNv0gV6Hp0r4DEivG/MfA1pJR0YqCaKTK
	f/yxuPdc3NMyar4sRqOtnS5VczU1GCGVeiENx4LglMEFsv/ARt9CAQrZaw8AupgGI0mS2Hot+x2
	LR5HA7w8AeM6h0mjC30YHteDZbtw3VCF+TabrNAYv
X-Gm-Gg: Acq92OHF+q8Mib9K7ptqYntiETrCg7DdrXoA48tJxyrvY2hZkUD/gSncXchVWfM+Vut
	kzEUStNbaz4WrAn5CXZ3Cop4moM5y35in7okvZvm3Ej4SceJsNzH1UcGkogDYJIPEsLsOJmHkuO
	yVblcqlVQHolDxXdLacXChG795tqPVysSs3Gd+ByRbb+S3cK3Xv/+yexJrALSTthx6LsBluWcQ1
	3qgSSewDd7+oaADFQGdTK00qSCuTm7R6cMwfTB6RSxAWJuULxZXmJo9JBzdKTRz8ALcBWyKNafB
	S3skbEs4tCEQ4E+hqFA=
X-Received: by 2002:a05:6402:a2d0:20b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-67f67ef2d93mr23979a12.1.1778387499977; Sat, 09 May 2026
 21:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507211304.3046526-1-hramamurthy@google.com>
 <20260507211304.3046526-2-hramamurthy@google.com> <50d567e8-abce-48d4-b1c4-6ac0459382f2@intel.com>
In-Reply-To: <50d567e8-abce-48d4-b1c4-6ac0459382f2@intel.com>
From: Jordan Rhee <jordanrhee@google.com>
Date: Sat, 9 May 2026 21:31:28 -0700
X-Gm-Features: AVHnY4Jnm4Yu7AnXr-nk7ebLU3ZOl7aXDM4PY7-PD67eYbBwL4RKXGQYbBegzIQ
Message-ID: <CA+mzVttmJRncoue-E0McM1eieAp7YOY_EYZsvA7-pzjAj90aZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/3] gve: skip error logging for retryable
 AdminQ commands
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	jstultz@google.com, tglx@kernel.org, sboyd@kernel.org, willemb@google.com, 
	nktgrg@google.com, jfraker@google.com, ziweixiao@google.com, 
	maolson@google.com, thostet@google.com, alok.a.tiwari@oracle.com, 
	pkaligineedi@google.com, horms@kernel.org, dwmw2@infradead.org, 
	yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E5929502911
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordanrhee@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 2:15=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 5/7/2026 2:13 PM, Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > AdminQ commands may return -EAGAIN under certain transient conditions.
> > These commands are intended to be retried by the driver, so logging
> > a formal error to the system log is misleading and creates
> > unnecessary noise.
> >
> > Modify the logging logic to skip the error message when the result
> > is -EAGAIN, and move logging to dev_err_ratelimited() to avoid
> > spamming the log.
> >
>
> Excellent!
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> > Reviewed-by: Joshua Washington <joshwash@google.com>
> > Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> > Changes in v4:
> > - call out change to dev_err_ratelimited() in the commit message (Jacob=
 Keller)
> > - remove extra print when adminQ status is GVE_ADMINQ_COMMAND_UNSET (Ja=
cob Keller)
> > ---
> >  drivers/net/ethernet/google/gve/gve_adminq.c | 27 +++++++++++++++-----
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 08587bf40ed4..a65b14835aa0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -416,16 +416,10 @@ static bool gve_adminq_wait_for_cmd(struct gve_pr=
iv *priv, u32 prod_cnt)
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
> >       case GVE_ADMINQ_COMMAND_UNSET:
> > -             dev_err(&priv->pdev->dev, "parse_aq_err: err and status b=
oth unset, this should not be possible.\n");
> >               return -EINVAL;
> >       case GVE_ADMINQ_COMMAND_ERROR_ABORTED:
> >       case GVE_ADMINQ_COMMAND_ERROR_CANCELLED:
> > @@ -455,6 +449,16 @@ static int gve_adminq_parse_err(struct gve_priv *p=
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
> > @@ -482,9 +486,18 @@ static int gve_adminq_kick_and_wait(struct gve_pri=
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

Sashiko says:
---
This isn't a bug, but should the variable err be declared as an int?
The variable err is declared at the beginning of this loop as a u32, but it
receives the return value of gve_adminq_parse_err() which returns signed in=
t
error codes such as -EAGAIN.

When checking err !=3D -EAGAIN here, the code compares an unsigned 32-bit
integer to a negative constant. While this may evaluate correctly due to tw=
o's
complement wrap-around, it can trigger compiler warnings for signed and
unsigned integer comparisons.
---

Yes, it should be an int, will fix in v7.

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

