Return-Path: <netdev+bounces-280906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB6VJ/vG6mlfDgAAu9opvQ
	(envelope-from <netdev+bounces-280906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:27:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8DD458B64
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16EE5300CBF6
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F256242D7F;
	Fri, 24 Apr 2026 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcAn7kqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA923645D
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776994039; cv=pass; b=Njfag8l8V38Qln37s1Z2hBYCNlWdOTh72cXDslUOQ3whYpQZArLYiEf3G1JbI58bo30z8KDILCem9a1fx8dXPJfnSy6FaTg0CQ3TzobRMy8tNCNdRh5g9eEMHbaRULA2PrbSAiDjjTAxW+Ife8z3OprQ+0McJQbS3tLN5laAR2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776994039; c=relaxed/simple;
	bh=P8CrcBNyuD0EXJ3oU77h+9EZ6+vBM8t5CK+EywCDcNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocq/dSC0mBSiLtAltVcjJ53I0WjldvSXq5fGj4cDhcpqI2rhRiXFIW+NsxZT4ymE8Zid+aM4Fe+NfZGK+E0j2+FFrOP+Bsev4VB7CnU9R20f42mZ6I1zQiM3dj60HmrCJ/vmeKz6AvhfEWBQ1KWRoP1YASP3fKhqGRuDxbcm4L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcAn7kqo; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35e576110adso5047341a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 18:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776994037; cv=none;
        d=google.com; s=arc-20240605;
        b=AJ2I7zEEoH6nMzxv+SgJdXOZLytu3Jmyeo8dQbzxvAgF8CmXU3U1LuMWim0eTuHQvx
         F4Wpg2YhvugbDDh5407Tn9R1KTNc+fEcUTdisK5GmG3gb/RZKUtFVu4e3D23BlM5lwCc
         rm3AUSMozkkw65zD9hKpHtawZPg59gTaqwdHH8vS7VccnaeKtxTAce8uUYrJZ9UG1pqK
         fonjeWarvzqQpRMjOStNv2xsipEgo62eUhRz/thz3Y4NLgo3S/k1LONI592sQDqnjibl
         xIKrqs4HVtI5/fsbSKIc5Dx7GK1aEeNjrl9aQjj0WvbDYApFiwCmUgfkb9dNhyZXjq31
         PPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/JFz7/atFKKa6Hg5z6nTuES4M46dTzQ7QvOnxwxtvc8=;
        fh=qtqsRlrOWpeKlb56AuyeLkeJLKMqQPRrK38puJF23Ko=;
        b=WWfcga92FRvVh8JmENUDURn5Maq9Df4rHJXy6UGXY6AiiN5CA1Eh1Z11OwP5wzrnxv
         N5YTL7O6xeLj9p+e0F61eGkiGCH3yI2LVy0v/8f1LmB5Z8haA5wmP50L1aR/bBE7vSwz
         jvkE5DfLezHXLt6E2SrD2tP743orDHxZMYoYrzjbe33anYWdgea5gtkflzz1KXavGwUK
         T5exLVESPzGqGO0WnWhmmARI2S12s0dYfWZBwPVLoR8MzrJD6an4MUyAxO4AXxmtsrZW
         lLKmOE8jJ07NsozG8U/qVDOpKV73hxRzOrx1BnvVd0kASMd2Na+xaB6lEWTk2r4sCO/4
         qQZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776994037; x=1777598837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JFz7/atFKKa6Hg5z6nTuES4M46dTzQ7QvOnxwxtvc8=;
        b=qcAn7kqoI784fayv0J4ki2in6onFryd6lFCoYqjVFD0cy1H3kzuO7WXaMDeXr7QLJs
         y48rsiA46+levV+T7L8ZEkXK3GxuIfX4ouDqaZgPU4WA8yT3dZwqoDvLWWQm114LJ1dp
         n2V34ShbP+nZ9Ij/9FmcUxEa4NrFWA7JwRAtRxvnTG5pEll/A5x7D6HLwA0XgYRcTdI5
         +CItUoddsawRpObi10oKdkZuDToewVZn4nkfdOWgKoTj3cck+z0U7C8hKbbCCpGkdbFz
         mCVlcT6AvQlRTXO/PISSeOxLM4kVY6Njc1TdsvBo/VVe7nUR9Z73W2toVcvIe0/FhfQt
         39DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776994037; x=1777598837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JFz7/atFKKa6Hg5z6nTuES4M46dTzQ7QvOnxwxtvc8=;
        b=ZAuTmP9Hytme3ZLAggcFRnbqaZX42g82/GEBJQ0DemLHI8hTEcY/bjCX/9QxT+bQ8W
         chCfZuthMRAYJRJ3SnCIZEmSDJrFTeAYZbahgHQyD9eWbiRiDWQJ/yMbGE+igiESKW25
         9DRi1MBe7b2tTmDgFQbxryf0piygXmC2MZSgwB1jQr4WQ1LYEPVVl6sqogJXwWn5hA+p
         yMpNQc1frjhayiCRiN8m5Vkkf0VDnKLHS/QYq0ojoJd1z0TnFrUKYz8aeGmszvUk46yC
         uAwhb1jpPy3H3dsLdznlORmzZLpOnJatVYh0oMDr3LD6SHPg61PKwqstaGLqpI8Vom53
         c9Ng==
X-Gm-Message-State: AOJu0YyrAtMylHuAdDawipBfYCOGoGdFatLQ0gg7sAbxPCPwhdqLmv/O
	DQvj1/u6QRs+AUJPWK+3iJ38Bh+Vma7jgVNa1JxJnQCwkhlXwh/VZ7Rt+Fj2BIgBA+vWNrmf2ka
	nS6xeoY3xUSiDo0+91ay1RECJBRlJpGTC5sOLEsx9
X-Gm-Gg: AeBDiesn71xqxqmo8XciF1XAVb1SsQ396hiuSqTIYEAXc3Xtbu71zeVT7JQI4GM+d3+
	rFH7RPxY4cxE2uOgypOokomwwG+HvosFrgds1MZEhfAHRZnNh1XDM8CGwJlFRHeBkTmkVA4DlWa
	EvkHZOi/vNzQFH7iek2FRUzLJPQzYMCftymhrXjJBgP7CvCGPwCyic/tFM67z5jbqztfKuxQzse
	Bpu41ncO1Va0QsWMN1X+i8joAafsT4dcR1XhQ2XCl9+kVe1zSNKl1gbvSIRvsQL8I7vWNgcgPiL
	BCPjXG8RsOBiMnEz51GpcXp7kgAjYlCcWYYsR3r/iRl8sXam50YDCJ+JMw==
X-Received: by 2002:a17:90b:558e:b0:35f:c1cc:fee0 with SMTP id
 98e67ed59e1d1-36140290941mr19499419a91.8.1776994036645; Thu, 23 Apr 2026
 18:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com> <20260420171837.455487-4-hramamurthy@google.com>
In-Reply-To: <20260420171837.455487-4-hramamurthy@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Thu, 23 Apr 2026 18:27:05 -0700
X-Gm-Features: AQROBzDKUrV_a--ZisFLZXpEGCggKgtRs207BgeNtBKiJ3TvnYZsvXcXguGHBMU
Message-ID: <CAHwYsirB8rkyuZ90h57OSC=MTW8L7Bs0GfJcHfA9PyJY-7DYaw@mail.gmail.com>
Subject: Re: [PATCH net 3/4] gve: Use default min ring size when device option
 values are 0
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0A8DD458B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280906-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 20, 2026 at 10:18=E2=80=AFAM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Pin-yen Lin <treapking@google.com>
>
> On gvnic devices that support reporting minimum ring sizes, the device
> option always includes the min_(rx|tx)_ring_size fields, and the values
> will be 0 if they are not configured to be exposed. This makes the
> driver allow unexpected small ring size configurations from the
> userspace.
>
> Use the default ring size in the driver if the min ring sizes from the
> device option are 0.
>
> This was discovered by drivers/net/ring_reconfig.py selftest.
>
> Cc: stable@vger.kernel.org
> Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the =
device")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index b72cc0fa2ba2..57d898f6fa82 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
>                 *dev_op_modify_ring =3D (void *)(option + 1);
>
>                 /* device has not provided min ring size */
> -               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> +               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE ||
> +                   be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) =
=3D=3D 0 ||
> +                   be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) =
=3D=3D 0)

Sashiko says:

Does this introduce an out-of-bounds read regression if the option length
is between 9 and 11?
The length check earlier in the switch case only ensures option_length is a=
t
least GVE_DEVICE_OPTION_NO_MIN_RING_SIZE (which is 8). The new condition
reads min_tx_ring_size, which sits at bytes 10-11 of the structure.
If an option length of 10 is provided, the condition would read past the
provided data length. Could this trigger a page fault if the option payload
happens to be placed at the very end of an unmapped DMA page boundary?
Could this introduce a time-of-check to time-of-use regression? Can these
values be modified by the device between this check and when they are used
later?
Since dev_op_modify_ring points into shared DMA memory, the values are
fetched here for validation. If the device alters the DMA memory to 0 after
this check has completed, would the driver bypass this validation when
applying the values later, leading to a minimum ring size of 0?
Does this introduce a logic regression by discarding a valid configuration
for one ring if the other ring's size is 0?
For example, if min_rx_ring_size is 0 but min_tx_ring_size is explicitly
configured to a valid size like 1024, setting a single default_min_ring_siz=
e
flag seems to force both rings to use their default fallback values instead
of evaluating their validity independently.

This should not be an issue because the GVNIC never returns an option
length between 9 and 11. Depending on the GVNIC version, it either
omits the ring sizes or includes both RX and TX ring sizes (even if
the values are 0).

>                         priv->default_min_ring_size =3D true;
>                 break;
>         case GVE_DEV_OPT_ID_FLOW_STEERING:
> --
> 2.54.0.rc0.605.g598a273b03-goog
>

Regards,
Pin-yen

