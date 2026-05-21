Return-Path: <netdev+bounces-290598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uVFJC6tWD2o4JQYAu9opvQ
	(envelope-from <netdev+bounces-290598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:02:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7754C5AB4F1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC4530262E0
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264DD38E8DE;
	Thu, 21 May 2026 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9Bq91MP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52D38D3E6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390120; cv=pass; b=VtvW8UFPdJalkObPjNUQclCvTSCxvsDVKyIXQ2lR+Xdk2j36ZCMFNC8XjRtfvvdTqiDg+N45am17kfVuyM6n2ucNlonL35PRn8gtShI5Kylve0g9F8bluSaF0b8DilSF2tGrQSpecG/9pp2348hC2bDxM5ga01TdH1IVF1YQUVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390120; c=relaxed/simple;
	bh=pVfBvs09rroPMhGv6Za+H/vN+sbZFgg8wCnbECEIVx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL3SUJWxd9ItJEgjBgYW+OyCDHLUCgSmEvu+dKEXbgN+vUjIatTw2h6aMvE/gamV10MVrajuUlO22GjIDsaNrtuIluuILCXyUp9qz0bAaKzNgs78IVmZhEkV9qUlTkat2aiJi7QdqlI2GZMiu7XFHEiGTTnMN2IXHTSEej+U9ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9Bq91MP; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso1217871766b.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779390117; cv=none;
        d=google.com; s=arc-20240605;
        b=O19L8MZP8Nz4EB1OV5W2hAS/S5SDgIppwiyS7Qz+8GmQj/IjTgXDZw63SIxMxysZCb
         y9Q42mc7KTpqmqRMS2LHz0VU3BLVm1SNJBgFkv1+BxXgJXEtDDUwQWiP3f5hmtwv+2lT
         ze3h9xIox+M6GiBFBo+ZNrp3sEtlJN7HroqkqSfRU02ekYraLVQq1UOHyYiPD4ulKLBL
         nHbtbXfmxycCIuTv0d00qe8Zl6bRgYmzDbiqBdayC/e2TocBt031zVfALTi6qvqqwxlj
         uKihBt4bVP03aU76KsBkwTE42KGxJ/yE5uqwNlMKIbHxEd3wRum5Gf3HTGiMx36NFzx6
         FTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o8hbcfTcGjAylB+heF6xWsG/Q4WQKOBAGW0X1ZZWNUE=;
        fh=bIPDoVzdbeKk5OadRvTPQs4GLiL3hh44CtpP7fQRhjY=;
        b=ZpcSeb8Uy8tfvP+B59Qr1+k4Elw2+KxWm9eaDniUM+bXSmZR3quV75LPFlVpEV2pnR
         lV4pr27YRuJvI9+21Djq81GyNWzhTmp1NZFaFwvJp9gEJ69EWkyQt4w7ovQnCQQnBFZO
         ieh3Jemu+GXKEvjAQGLP9uWHpVMDjjJPUk0abMbr5KVYFWjywqlceum7v1PfcuG0BUh3
         HJZFqfRecb806DSEl5PYpB6zTcT7LWtWg3AHvb3upFZKsEvgcPn+/+6H2s6ePEYX2h1X
         i9+N/CJnADdMKD8DQ9FyGXKuWMD7lVZQgXQaI+mhtkDuArB+cDqi5VZcUlfvXZl8HoGd
         ELvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779390117; x=1779994917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8hbcfTcGjAylB+heF6xWsG/Q4WQKOBAGW0X1ZZWNUE=;
        b=O9Bq91MPgdPZix6+v/0+Tb9n4wKmEyqfodZbNYRZFZ9xheHy9aQ09iZ/dveZBQHc9H
         iXBuPdv67hEapnkFB7rMvDAhzcI9tbGkX1MOMYQAFEVPkZLpOIV+JV274ni2p48hM45d
         vcEuXt1yMc3ntYj6fVOv0odwYpaR+D6l4WZvCJ7mpRMspNlczem6ukNVyC02j+ur6Ahs
         3FDz/PjJjeSXwaQT7MFUdKkloEpLGJsvmk2XffoxC+FdbmTVZj8VElTU+twG10vZB7hc
         y4DlVpJNvBbp+aQCUIxsqUkOXErNe2H0IneSDsS0xe4jLmy0s9qHE2IqckBke3mIBoxD
         d4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390117; x=1779994917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8hbcfTcGjAylB+heF6xWsG/Q4WQKOBAGW0X1ZZWNUE=;
        b=PBSYIM4Tas6Wq7sIAVMmQ9nWPMji516vrQDUGMT7ic6d91B+k5/Y7kKTtifENKzPkZ
         KpWet4r9irZHk3TxT+sJmaWNaY0jizeIgoSnOd76Xw3cQQiatu61ttiA4GP9Dq4jD0wr
         FVw5nxUBTrbaJN1O+SR7fQvcjgqCyqRLKL1d3e0J+fjzw9JR3jJhIwdEoyFnGOQwOSgW
         TWz4wxu72Bt0VHLK5PPE50q3jRTmY70JKF/m2Bgxwgcd409rogjJRSMv9/ah/9a/sr6G
         wpOOIXnlbXaEG/qlNgBxAnDgII9Aa3EZ+Xqll5i4DcF14wPAxa0sJT6QlaFK/3LCtIhH
         OZeQ==
X-Gm-Message-State: AOJu0YyUsV4y+6zGAt99hGc9Wn1H9IgodUgGNwVXiHl5oh1Si8DioAyu
	/mu8yjjD9BpLJ42ELFsX1FP1rNqOa4uS4cs6lrWrIyAU578emFa/TdYDR7cv9dLZrWR9Xg24qEX
	ti1gJKH/NAe5fFhRijOqfGhMNteodUlg=
X-Gm-Gg: Acq92OFvu0FDQaRwSfDbBrPZ2nyzNATNm/12LhGp27AX1RDO8g2Uk0aJjD/Ii3LSh9v
	UHLc4ag0f8XYBLl+2yYWPnGwxJQmFBY4aEI4p63OwdzT/GyXNIRLLITo1pLco3euNWWkoHajMXi
	cQZzZdmKmkUHE0C43GntkQc4tk46/6fUVMjR8vBuk7GNqG7GRdu5HH0XufUpls0k961+CfP8mKu
	UPAU8d+/UIleAJQzvOr/s3s+nxguqb+4ES6Gp7711ZmZl3KDu/S01x4ukmyI+GyAzJgQMEbkRt+
	ru6PJrC2eaXa0yQq3Ob/I5Z+oJlkW6NRKKtZrj9dv7PNd8r+UIAeb+4LszyNfEo0AYRIP61FyFp
	YWU0ZuQh+Y47K2l/vtfiq18UBmvIe7UpDBIoI7cTOnya7RMTjNoM5Zv0Xbg==
X-Received: by 2002:a17:906:cc14:b0:bdc:9d31:3f91 with SMTP id
 a640c23a62f3a-bdd22f2831amr27212566b.15.1779390116596; Thu, 21 May 2026
 12:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517033621.1839397-1-rosenp@gmail.com> <b9a1ce9c-1f5c-485c-8d65-bb00c7850842@redhat.com>
In-Reply-To: <b9a1ce9c-1f5c-485c-8d65-bb00c7850842@redhat.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 21 May 2026 12:01:44 -0700
X-Gm-Features: AVHnY4IQuxon6aIF8DRG31sqE-2PD4Om-54mJPkKk-JCkhYT7Ra2dE96GPcPL9g
Message-ID: <CAKxU2N_r2eLdLs=+eew+6-Oma_gmgnv-6yjeykyxO-3X0EoHYQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ibm: emac: Clear MAL descriptors without memset
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290598-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7754C5AB4F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 2:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/17/26 5:36 AM, Rosen Penev wrote:
> > Clear MAL descriptor rings with explicit field stores instead of
> > memset().  The descriptor rings are carved from MAL coherent DMA memory=
,
> > which may be mapped uncached on 32-bit powerpc.  The optimized memset()
> > path can use dcbz there and trigger an alignment warning.
> >
> > The skb tracking arrays remain ordinary CPU memory and still use memset=
().
> >
> > Assisted-by: Codex:GPT-5.5
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/ibm/emac/core.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/etherne=
t/ibm/emac/core.c
> > index 1fd7cb50c568..7ab5c944f5de 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -1161,6 +1161,17 @@ static void emac_clean_rx_ring(struct emac_insta=
nce *dev)
> >       }
> >  }
> >
> > +static void emac_clear_mal_desc(struct mal_descriptor *desc, int count=
)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             desc[i].ctrl =3D 0;
> > +             desc[i].data_len =3D 0;
> > +             desc[i].data_ptr =3D 0;
>
> Sashiko noted that the compiler could still optimize the above to a
> memset(). Perhaps a barrier() is needed here?
The canonical way to do this is WRITE_ONCE() AFAIK.

In practice it seems it's not an issue. That is

https://lore.kernel.org/all/2e3acfe63d289c6fba366e16973c9ab8369e8b75.163180=
3922.git.christophe.leroy@csgroup.eu/

no longer triggers.
>
> /P
>

