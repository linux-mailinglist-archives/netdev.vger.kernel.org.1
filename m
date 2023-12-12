Return-Path: <netdev+bounces-56434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A240280ED97
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD06D1F2159D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437AA61FAE;
	Tue, 12 Dec 2023 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACDlkDqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A083
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:30:51 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f84533beso65621231fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702387849; x=1702992649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rnHxzxdkl12W8MrO4FkPzpSQaxsvRUvksACzlgePBuI=;
        b=ACDlkDqOQEzH8PdX2EpeIQBEhd1Os0GHPTjnmPhSQhyi3qKfnR1AJIJI39X8vaAMM6
         utSiiUDoyASMfNVkiMc6xNUzQwsRFSJBLwKP4OmG7LOwdJSwlelpEqCk+aMpJAAJy1p7
         AP+jB4eFHArj0jazQQmFR7JJ0C43Z+1U6BW/cfKqz3Q86gPJaSSl56lZ+Qr+AuzUhM9G
         jWVL9u1Y5ryAbVlUi+3GiRnxPanrHIW8WgXoRRk971JHyOPWsoNSfG7L/veZjCfA0l63
         ybDjQdL4onKMUcwLBOzeTJcl8vRuxGfwi7/T/uGOd7cUX8lQXlGhgYhvX0mhMFV3Dy9I
         A9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387849; x=1702992649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnHxzxdkl12W8MrO4FkPzpSQaxsvRUvksACzlgePBuI=;
        b=PBvHUbyQheilelWIN71s90XJUtiMyoGmeUMvnMtUwCV1AvehtaynGTlP0tt/krHpy/
         F1gUCLT3UMW7eNaWxsheT6HmRA5Q0djUEvh2BNL/gZw4pTZ6aZbOJEvaXbmz9vgUvsR+
         U8HmzCEvJngAReiTvOBLTznuBRcgRDNHIlzlHfTAS0yp/lXZ/HLYHdBwZI8K7qEOsO5y
         qES8RE55G7UXAS7HwL5vjVe6+Wmxn8eLo27T4+7hlVIK/TaH+cWuES9RF40H7Jkd52Sk
         Rw7vNromWSQHgsX5km7lk4cGCoLF3nybEF3KBX1oCyAhc6CQo5KMFh17Z7OO8M8Jtx1d
         zvqQ==
X-Gm-Message-State: AOJu0Yw1i7UdwD/bhEZvfzCIitZOnwKVhJjZyh5SLH7VI6agYiSZR3+/
	QiCZDhziJNNTNEA+xe8+P/wo/vTbOJh3yfcHdsEvDpySV68=
X-Google-Smtp-Source: AGHT+IHI9IVjfPCJadHhVxOaufesKF3ctO+J206EUG6/SbKIxubOQ34yuH89HQd89wy98rMPA1GPZu45skzI3Jc7a7g=
X-Received: by 2002:a2e:b954:0:b0:2cc:1c2d:c187 with SMTP id
 20-20020a2eb954000000b002cc1c2dc187mr1751683ljs.104.1702387849083; Tue, 12
 Dec 2023 05:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lucas Pereira <lucasvp@gmail.com>
Date: Tue, 12 Dec 2023 10:30:31 -0300
Message-ID: <CAG7fG-adZdzc-8JG0dbHUQo+cpUunfm_qOi8iP3TqQPsD94=SQ@mail.gmail.com>
Subject: Stop traffic on an established ipsec tunnel
To: netdev@vger.kernel.org
Cc: "webguy@marc.info" <webguy@marc.info>, Alex Brahm <alexbrahm@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000003d50d060c500f41"

--00000000000003d50d060c500f41
Content-Type: multipart/alternative; boundary="00000000000003d50a060c500f3f"

--00000000000003d50a060c500f3f
Content-Type: text/plain; charset="UTF-8"

*Situation:*


I have a project related to a firewall that includes IPSEC VPN.
Intermittently, every x days (the shortest period of time identified was 11
days, and the longest was 133 days), I experience a VPN issue. The problem
detailed below occurs in a few deployments with a large number of VPN
tunnels.

*Problem:*

The issue is that the VPN traffic gets interrupted.



We establish two LAN-to-LAN tunnels and, after a certain period of time,
communication between the endpoints ceases. The system uses strongSwan for
tunnel establishment. StrongSwan successfully installs the Security
Associations (SAs) in the kernel, and everything works fine for several
days.



However, at some point, the following error occurs:



ping -I 10.165.112.248 10.10.55.1

PING 10.10.55.1 (10.10.55.1) from 10.165.112.248: 56(84) bytes of data.

ping: sendmsg: Device or resource busy

ping: sendmsg: Device or resource busy

ping: sendmsg: Device or resource busy

ping: sendmsg: Device or resource busy

When the VPN issue arises, the counter for the following parameter
increases incessantly:



watch -n1 'cat /proc/net/xfrm_stat'

XfrmOutStateProtoError (see attachment)

When the tunnel is functioning, the parameter stabilizes.



*IPs:*

VPN Concentrator: 10.165.112.248

Branch: 10.10.55.1



*Versions original:*

Kernel: Linux 5.4.113-1.el7.elrepo.x86_64



*We try the new kernel versions + path:  *

Kernel: Linux 5.4.249-1.el7.elrepo.x86_64

Kernel: Linux 6.4.11.el7.elrepo.x86_64

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/xfrm?h=v6.5.9&id=de0bfd6026c85de3a0a0db2766ab740733d1631e

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/xfrm?h=v6.5.9&id=de0bfd6026c85de3a0a0db2766ab740733d1631e

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/xfrm?h=v6.5.9&id=071bba39638f6532040aca3bdabba469186f631c

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/xfrm?h=v6.5.9&id=071bba39638f6532040aca3bdabba469186f631c



*StrongSwan:*

strongswan-sqlite-5.9.7-520.x86_64

strongswan-tnc-imcvs-5.9.7-520.x86_64

strongswan-charon-nm-5.9.7-520.x86_64

strongswan-libipsec-5.9.7-520.x86_64

strongswan-5.9.7-520.x86_64



*After update: *

strongswan-sqlite-5.9.11.x86_64

strongswan-tnc-imcvs-5.9.11.x86_64

strongswan-charon-nm-5.9.11.x86_64

strongswan-libipsec-5.9.11.x86_64

strongswan-5.9.11.x86_64



*Tried change some confs:*


we are testing these configurations:

#Disable aesni_intel modeule
lsmod |grep -i aesni_intel
aesni_intel           372736  4

vi /boot/grub2/grub.cfg
Foi adicionado "module_blacklist=aesni_intel"

cat /boot/grub2/grub.cfg |grep -i aesni_intel
        linux16 /vmlinuz-5.4.113-1.el7.elrepo.x86_64
root=UUID=222c8741-7ce5-4f57-95b6-f435fce5b9b9 ro
vconsole.font=latarcyrheb-sun16 vconsole.keymap=us
rd.luks.uuid=luks-83730611-a1fc-492a-af40-bf3555dae23f
rd.luks.key=/etc/._key rd.luks.options=allow-discards biosdevname=0
splash=silent maxcpus=2 possible_cpus=2 mem=5G quiet
qat_c3xxx.blacklist=yes qat_c62x.blacklist=yes rdblacklist=qat_c3xxx
rdblacklist=qat_c62x module_blacklist=qat_c3xxx
module_blacklist=qat_c62x module_blacklist=aesni_intel net.ifnames=0
elevator=noop rd.plymouth=0 plymouth.enable=0 console=tty0
console=ttyS0,115200

depmod
reboot

lsmod |grep -i aesni_intel

------
On /etc/strongswan/strongswan.d/charon/kernel-netlink.conf

# Whether to perform concurrent Netlink XFRM queries on a single socket.
parallel_xfrm = yes

# Whether to always use XFRM_MSG_UPDPOLICY to install policies.
policy_update = yes

2 - /etc/strongswan/strongswan.d/charon.conf (mudar de 32 para zero)
replay_window = 0

3 - /etc/strongswan/swanctl/swanctl.conf

# IPsec replay window to configure for this CHILD_SA.
# replay_window = 32
replay_window = 0


systemctl restart strongswan



*Analyses Conducted:*



To resolve the problem, we have identified two workaround solutions:



*Change of the hash protocol in the tunnels.*

When we change the encryption algorithm from MD5 to SHA1, it works, but
after x days the problem reoccurs. (Not necessarily from MD5 to SHA1, but
to any other). It is necessary to switch to an algorithm that is not
currently in use, meaning, if we switch back to MD5, it works. However,
this solution is temporary. If we switch within a short period (1 hour to
the previous), the problem persists, but if we switch after several days,
the problem is temporarily resolved.



*Server reboot.*

The problem is only resolved by restarting the server, as merely restarting
the service is not sufficient. Even if after removing and reinstalling the
xfrm kernel modules, the problem persists.



The firewall rules have already been validated and are correct.

Even with the firewall open, the problem persists, which means, with no
rules in place.

The firewall policy and the frm state are okay.



*Logs and Evidence is attached.*



Best regards,
Lucas

--00000000000003d50a060c500f3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" style=3D"border:0px;font-variant-num=
eric:inherit;font-variant-east-asian:inherit;font-variant-alternates:inheri=
t;font-stretch:inherit;font-size:15px;line-height:inherit;font-kerning:inhe=
rit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-align:bas=
eline;color:rgb(36,36,36)"><span class=3D"gmail-x_gmail-ui-provider gmail-x=
_gmail-a gmail-x_gmail-b gmail-x_gmail-c gmail-x_gmail-d gmail-x_gmail-e gm=
ail-x_gmail-f gmail-x_gmail-g gmail-x_gmail-h gmail-x_gmail-i gmail-x_gmail=
-j gmail-x_gmail-k gmail-x_gmail-l gmail-x_gmail-m gmail-x_gmail-n gmail-x_=
gmail-o gmail-x_gmail-p gmail-x_gmail-q gmail-x_gmail-r gmail-x_gmail-s gma=
il-x_gmail-t gmail-x_gmail-u gmail-x_gmail-v gmail-x_gmail-w gmail-x_gmail-=
x gmail-x_gmail-y gmail-x_gmail-z gmail-x_gmail-ab gmail-x_gmail-ac gmail-x=
_gmail-ae gmail-x_gmail-af gmail-x_gmail-ag gmail-x_gmail-ah gmail-x_gmail-=
ai gmail-x_gmail-aj gmail-x_gmail-ak" dir=3D"ltr" style=3D"border:0px;font:=
inherit;margin:0px;padding:0px;vertical-align:baseline;color:inherit"><span=
 style=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight:in=
herit;font-stretch:inherit;font-size:14px;line-height:inherit;font-family:i=
nherit;font-kerning:inherit;font-feature-settings:inherit;margin:0px;paddin=
g:0px;vertical-align:baseline;color:inherit"><p style=3D"margin-bottom:0px;=
margin-top:0px"><span style=3D"border:0px;font:inherit;margin:0px;padding:0=
px;vertical-align:baseline;color:inherit"><strong>Situation:</strong>=C2=A0=
=C2=A0</span></p><p style=3D"margin-bottom:8px;margin-top:0px"><br aria-hid=
den=3D"true"></p><p style=3D"margin-bottom:8px;margin-top:0px"><span style=
=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical-align:baseline;=
color:inherit">I have a project related to a=C2=A0firewall that=C2=A0includ=
es=C2=A0IPSEC VPN. Intermittently,=C2=A0every x days (the shortest period o=
f time identified was 11 days, and the longest was 133 days), I experience =
a VPN issue. The problem detailed below occurs in a few deployments with a =
large number of VPN tunnels.</span></p></span></span></div><div dir=3D"ltr"=
 style=3D"border:0px;font-variant-numeric:inherit;font-variant-east-asian:i=
nherit;font-variant-alternates:inherit;font-stretch:inherit;font-size:15px;=
line-height:inherit;font-kerning:inherit;font-feature-settings:inherit;marg=
in:0px;padding:0px;vertical-align:baseline;color:rgb(36,36,36)"><span class=
=3D"gmail-x_gmail-ui-provider gmail-x_gmail-a gmail-x_gmail-b gmail-x_gmail=
-c gmail-x_gmail-d gmail-x_gmail-e gmail-x_gmail-f gmail-x_gmail-g gmail-x_=
gmail-h gmail-x_gmail-i gmail-x_gmail-j gmail-x_gmail-k gmail-x_gmail-l gma=
il-x_gmail-m gmail-x_gmail-n gmail-x_gmail-o gmail-x_gmail-p gmail-x_gmail-=
q gmail-x_gmail-r gmail-x_gmail-s gmail-x_gmail-t gmail-x_gmail-u gmail-x_g=
mail-v gmail-x_gmail-w gmail-x_gmail-x gmail-x_gmail-y gmail-x_gmail-z gmai=
l-x_gmail-ab gmail-x_gmail-ac gmail-x_gmail-ae gmail-x_gmail-af gmail-x_gma=
il-ag gmail-x_gmail-ah gmail-x_gmail-ai gmail-x_gmail-aj gmail-x_gmail-ak" =
dir=3D"ltr" style=3D"border:0px;font:inherit;margin:0px;padding:0px;vertica=
l-align:baseline;color:inherit"><br aria-hidden=3D"true"></span></div><div =
dir=3D"ltr" style=3D"border:0px;font-variant-numeric:inherit;font-variant-e=
ast-asian:inherit;font-variant-alternates:inherit;font-stretch:inherit;font=
-size:15px;line-height:inherit;font-kerning:inherit;font-feature-settings:i=
nherit;margin:0px;padding:0px;vertical-align:baseline;color:rgb(36,36,36)">=
<span class=3D"gmail-x_gmail-ui-provider gmail-x_gmail-a gmail-x_gmail-b gm=
ail-x_gmail-c gmail-x_gmail-d gmail-x_gmail-e gmail-x_gmail-f gmail-x_gmail=
-g gmail-x_gmail-h gmail-x_gmail-i gmail-x_gmail-j gmail-x_gmail-k gmail-x_=
gmail-l gmail-x_gmail-m gmail-x_gmail-n gmail-x_gmail-o gmail-x_gmail-p gma=
il-x_gmail-q gmail-x_gmail-r gmail-x_gmail-s gmail-x_gmail-t gmail-x_gmail-=
u gmail-x_gmail-v gmail-x_gmail-w gmail-x_gmail-x gmail-x_gmail-y gmail-x_g=
mail-z gmail-x_gmail-ab gmail-x_gmail-ac gmail-x_gmail-ae gmail-x_gmail-af =
gmail-x_gmail-ag gmail-x_gmail-ah gmail-x_gmail-ai gmail-x_gmail-aj gmail-x=
_gmail-ak" dir=3D"ltr" style=3D"border:0px;font-style:inherit;font-variant:=
inherit;font-stretch:inherit;font-size:inherit;line-height:inherit;font-fam=
ily:inherit;font-kerning:inherit;font-feature-settings:inherit;margin:0px;p=
adding:0px;vertical-align:baseline;color:inherit"><p style=3D"font-weight:i=
nherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;fon=
t-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;l=
ine-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-f=
eature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;colo=
r:black"><b>Problem:</b>=C2=A0=C2=A0</span></p><p style=3D"font-weight:inhe=
rit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-v=
ariant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line=
-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feat=
ure-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;color:b=
lack">The issue is that the VPN traffic gets interrupted. =C2=A0</span></p>=
<p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0=
px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch=
:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;fo=
nt-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;ver=
tical-align:baseline;color:black">=C2=A0 =C2=A0</span></p><p style=3D"font-=
weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inh=
erit;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-siz=
e:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inheri=
t;font-feature-settings:inherit;margin:0px;padding:0px;vertical-align:basel=
ine;color:black">We establish two LAN-to-LAN tunnels and, after a certain p=
eriod of time, communication between the endpoints ceases. The system uses =
strongSwan for tunnel establishment. StrongSwan successfully installs the S=
ecurity Associations (SAs) in the kernel, and everything works fine for sev=
eral days. =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px =
8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inherit;font=
-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;fon=
t-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inheri=
t;margin:0px;padding:0px;vertical-align:baseline;color:black">=C2=A0 =C2=A0=
</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=
=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;=
font-stretch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,s=
ans-serif;font-kerning:inherit;font-feature-settings:inherit;margin:0px;pad=
ding:0px;vertical-align:baseline;color:black">However, at some point, the f=
ollowing error occurs: =C2=A0</span></p><p style=3D"font-weight:inherit;mar=
gin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:=
inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height=
:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-set=
tings:inherit;margin:0px;padding:0px;vertical-align:baseline;color:black">=
=C2=A0 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"=
><span style=3D"border:0px;font-style:inherit;font-variant:inherit;font-wei=
ght:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-fa=
mily:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;ma=
rgin:0px;padding:0px;vertical-align:baseline;color:black">ping -I 10.165.11=
2.248 10.10.55.1 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0p=
x 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inheri=
t;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inher=
it;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:=
inherit;margin:0px;padding:0px;vertical-align:baseline;color:black">PING 10=
.10.55.1 (10.10.55.1) from=C2=A0<a href=3D"http://10.165.112.248/" style=3D=
"border:0px;font:inherit;margin:0px;padding:0px;vertical-align:baseline">10=
.165.112.248</a>: 56(84) bytes of data. =C2=A0</span></p><p style=3D"font-w=
eight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inhe=
rit;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size=
:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit=
;font-feature-settings:inherit;margin:0px;padding:0px;vertical-align:baseli=
ne;color:black">ping: sendmsg: Device or resource busy =C2=A0</span></p><p =
style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;=
font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:in=
herit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-=
kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertic=
al-align:baseline;color:black">ping: sendmsg: Device or resource busy =C2=
=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span sty=
le=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight:inheri=
t;font-stretch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos=
,sans-serif;font-kerning:inherit;font-feature-settings:inherit;margin:0px;p=
adding:0px;vertical-align:baseline;color:black">ping: sendmsg: Device or re=
source busy =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px=
 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inherit;fon=
t-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;fo=
nt-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inher=
it;margin:0px;padding:0px;vertical-align:baseline;color:black">ping: sendms=
g: Device or resource busy =C2=A0</span></p><p style=3D"font-weight:inherit=
;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-vari=
ant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-he=
ight:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature=
-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;color:blac=
k">When the VPN issue arises, the counter for the following parameter incre=
ases incessantly: =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0=
px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inher=
it;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inhe=
rit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings=
:inherit;margin:0px;padding:0px;vertical-align:baseline;color:black">=C2=A0=
 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span=
 style=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight:in=
herit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-family:A=
ptos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;margin:0=
px;padding:0px;vertical-align:baseline;color:black">watch -n1 &#39;cat /pro=
c/net/xfrm_stat&#39; =C2=A0</span></p><p style=3D"font-weight:inherit;margi=
n:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:in=
herit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:i=
nherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-setti=
ngs:inherit;margin:0px;padding:0px;vertical-align:baseline;color:black">Xfr=
mOutStateProtoError (see attachment) =C2=A0</span></p><p style=3D"font-weig=
ht:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit=
;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11=
pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;fo=
nt-feature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;=
color:black">When the tunnel is functioning, the parameter stabilizes. =C2=
=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span sty=
le=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight:inheri=
t;font-stretch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos=
,sans-serif;font-kerning:inherit;font-feature-settings:inherit;margin:0px;p=
adding:0px;vertical-align:baseline;color:black">=C2=A0 =C2=A0</span></p><p =
style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;=
font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:in=
herit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-=
kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertic=
al-align:baseline;color:black"><b>IPs:</b>=C2=A0=C2=A0</span></p><p style=
=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-=
style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit=
;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerni=
ng:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-al=
ign:baseline;color:black">VPN Concentrator: 10.165.112.248 =C2=A0</span></p=
><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:=
0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretc=
h:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;f=
ont-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;ve=
rtical-align:baseline;color:black">Branch: 10.10.55.1 =C2=A0</span></p><p s=
tyle=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;f=
ont-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inh=
erit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-k=
erning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertica=
l-align:baseline;color:black">=C2=A0 =C2=A0</span></p><p style=3D"font-weig=
ht:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit=
;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11=
pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;fo=
nt-feature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;=
color:black"><b>Versions original:</b>=C2=A0=C2=A0</span></p><p style=3D"fo=
nt-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:=
inherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-=
size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inh=
erit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-align:ba=
seline;color:black">Kernel: Linux 5.4.113-1.el7.elrepo.x86_64 =C2=A0</span>=
</p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"bord=
er:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-str=
etch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-seri=
f;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px=
;vertical-align:baseline;color:black">=C2=A0</span></p><p style=3D"font-wei=
ght:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inheri=
t;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:1=
1pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;f=
ont-feature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline=
;color:black"><b>We try the new kernel versions + path:=C2=A0=C2=A0</b></sp=
an></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"b=
order:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-=
stretch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-s=
erif;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:=
0px;vertical-align:baseline;color:black">Kernel: Linux 5.4.249-1.el7.elrepo=
.x86_64 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt=
"><span style=3D"border:0px;font-style:inherit;font-variant:inherit;font-we=
ight:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-f=
amily:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;m=
argin:0px;padding:0px;vertical-align:baseline;color:black">Kernel: Linux 6.=
4.11.el7.elrepo.x86_64 =C2=A0</span></p><p style=3D"font-weight:inherit;mar=
gin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:=
inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height=
:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-set=
tings:inherit;margin:0px;padding:0px;vertical-align:baseline;color:black"><=
a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
commit/net/xfrm?h=3Dv6.5.9&amp;id=3Dde0bfd6026c85de3a0a0db2766ab740733d1631=
e" id=3D"gmail-x_gmail-LPlnk431218" style=3D"border:0px;font:inherit;margin=
:0px;padding:0px;vertical-align:baseline">https://git.kernel.org/pub/scm/li=
nux/kernel/git/stable/linux.git/commit/net/xfrm?h=3Dv6.5.9&amp;id=3Dde0bfd6=
026c85de3a0a0db2766ab740733d1631e</a></span></p><p style=3D"font-weight:inh=
erit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-=
variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;lin=
e-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-fea=
ture-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;color:=
black"><a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/stable/li=
nux.git/commit/net/xfrm?h=3Dv6.5.9&amp;id=3Dde0bfd6026c85de3a0a0db2766ab740=
733d1631e" id=3D"gmail-x_gmail-LPlnk739709" style=3D"border:0px;font:inheri=
t;margin:0px;padding:0px;vertical-align:baseline">https://git.kernel.org/pu=
b/scm/linux/kernel/git/stable/linux.git/commit/net/xfrm?h=3Dv6.5.9&amp;id=
=3Dde0bfd6026c85de3a0a0db2766ab740733d1631e</a></span></p><p style=3D"font-=
weight:inherit;margin:0px 0px 8pt"><a href=3D"https://git.kernel.org/pub/sc=
m/linux/kernel/git/stable/linux.git/commit/net/xfrm?h=3Dv6.5.9&amp;id=3D071=
bba39638f6532040aca3bdabba469186f631c" id=3D"gmail-x_gmail-LPlnk392685" sty=
le=3D"border:0px;font:inherit;margin:0px;padding:0px;vertical-align:baselin=
e">https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/=
net/xfrm?h=3Dv6.5.9&amp;id=3D071bba39638f6532040aca3bdabba469186f631c</a></=
p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><a href=3D"https://gi=
t.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/xfrm?h=3D=
v6.5.9&amp;id=3D071bba39638f6532040aca3bdabba469186f631c" id=3D"gmail-x_gma=
il-LPlnk726614" style=3D"border:0px;font:inherit;margin:0px;padding:0px;ver=
tical-align:baseline">https://git.kernel.org/pub/scm/linux/kernel/git/stabl=
e/linux.git/commit/net/xfrm?h=3Dv6.5.9&amp;id=3D071bba39638f6532040aca3bdab=
ba469186f631c</a></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><s=
pan style=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight=
:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-famil=
y:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;margi=
n:0px;padding:0px;vertical-align:baseline;color:black">=C2=A0</span></p><p =
style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;=
font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:in=
herit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-=
kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertic=
al-align:baseline;color:black"><b>StrongSwan:</b>=C2=A0=C2=A0</span></p><p =
style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;=
font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:in=
herit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-=
kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertic=
al-align:baseline;color:black">strongswan-sqlite-5.9.7-520.x86_64 =C2=A0</s=
pan></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"=
border:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font=
-stretch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-=
serif;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding=
:0px;vertical-align:baseline;color:black">strongswan-tnc-imcvs-5.9.7-520.x8=
6_64 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><=
span style=3D"border:0px;font-style:inherit;font-variant:inherit;font-weigh=
t:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-fami=
ly:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;marg=
in:0px;padding:0px;vertical-align:baseline;color:black">strongswan-charon-n=
m-5.9.7-520.x86_64 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:=
0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inhe=
rit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inh=
erit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-setting=
s:inherit;margin:0px;padding:0px;vertical-align:baseline;color:black">stron=
gswan-libipsec-5.9.7-520.x86_64 =C2=A0</span></p><p style=3D"font-weight:in=
herit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font=
-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;li=
ne-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-fe=
ature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;color=
:black">strongswan-5.9.7-520.x86_64 =C2=A0</span></p><p style=3D"font-weigh=
t:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;=
font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11p=
t;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;fon=
t-feature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;c=
olor:black">=C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px=
 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inherit;fon=
t-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;fo=
nt-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inher=
it;margin:0px;padding:0px;vertical-align:baseline;color:black"><b>After upd=
ate:=C2=A0</b></span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt=
"><span style=3D"border:0px;font-style:inherit;font-variant:inherit;font-we=
ight:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-f=
amily:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;m=
argin:0px;padding:0px;vertical-align:baseline;color:black">strongswan-sqlit=
e-5.9.11.x86_64 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px=
 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inherit=
;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inheri=
t;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:i=
nherit;margin:0px;padding:0px;vertical-align:baseline;color:black">strongsw=
an-tnc-imcvs-5.9.11.x86_64 =C2=A0</span></p><p style=3D"font-weight:inherit=
;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-vari=
ant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-he=
ight:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature=
-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;color:blac=
k">strongswan-charon-nm-5.9.11.x86_64 =C2=A0</span></p><p style=3D"font-wei=
ght:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inheri=
t;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:1=
1pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;f=
ont-feature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline=
;color:black">strongswan-libipsec-5.9.11.x86_64 =C2=A0</span></p><p style=
=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-=
style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit=
;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerni=
ng:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-al=
ign:baseline;color:black">strongswan-5.9.11.x86_64 =C2=A0</span></p><p styl=
e=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font=
-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inheri=
t;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kern=
ing:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-a=
lign:baseline;color:black">=C2=A0</span></p><p style=3D"margin:0px 0px 8pt"=
><span style=3D"border:0px;font-style:inherit;font-variant:inherit;font-str=
etch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-seri=
f;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px=
;vertical-align:baseline;color:black"><b>Tried change some confs:</b></span=
></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"bor=
der:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-st=
retch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-ser=
if;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0p=
x;vertical-align:baseline;color:black"><br></span></p><pre class=3D"gmail-b=
z_comment_text" id=3D"gmail-comment_text_5" style=3D"font-weight:inherit;fo=
nt-size:medium;width:50em;color:rgb(0,0,0)">we are testing these configurat=
ions:

#Disable aesni_intel modeule
lsmod |grep -i aesni_intel
aesni_intel           372736  4
=20
vi /boot/grub2/grub.cfg
Foi adicionado &quot;module_blacklist=3Daesni_intel&quot;
=20
cat /boot/grub2/grub.cfg |grep -i aesni_intel
        linux16 /vmlinuz-5.4.113-1.el7.elrepo.x86_64 root=3DUUID=3D222c8741=
-7ce5-4f57-95b6-f435fce5b9b9 ro  vconsole.font=3Dlatarcyrheb-sun16 vconsole=
.keymap=3Dus rd.luks.uuid=3Dluks-83730611-a1fc-492a-af40-bf3555dae23f rd.lu=
ks.key=3D/etc/._key rd.luks.options=3Dallow-discards biosdevname=3D0 splash=
=3Dsilent maxcpus=3D2 possible_cpus=3D2 mem=3D5G quiet qat_c3xxx.blacklist=
=3Dyes qat_c62x.blacklist=3Dyes rdblacklist=3Dqat_c3xxx rdblacklist=3Dqat_c=
62x module_blacklist=3Dqat_c3xxx module_blacklist=3Dqat_c62x module_blackli=
st=3Daesni_intel net.ifnames=3D0 elevator=3Dnoop rd.plymouth=3D0 plymouth.e=
nable=3D0 console=3Dtty0 console=3DttyS0,115200
=20
depmod
reboot
=20
lsmod |grep -i aesni_intel

------
On /etc/strongswan/strongswan.d/charon/kernel-netlink.conf

# Whether to perform concurrent Netlink XFRM queries on a single socket.=20
parallel_xfrm =3D yes

# Whether to always use XFRM_MSG_UPDPOLICY to install policies.   =20
policy_update =3D yes
=20
2 - /etc/strongswan/strongswan.d/charon.conf (mudar de 32 para zero)
replay_window =3D 0
=20
3 - /etc/strongswan/swanctl/swanctl.conf
=20
# IPsec replay window to configure for this CHILD_SA.
# replay_window =3D 32
replay_window =3D 0


systemctl restart strongswan
</pre><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"bo=
rder:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-s=
tretch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-se=
rif;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0=
px;vertical-align:baseline;color:black"><br class=3D"gmail-Apple-interchang=
e-newline"></span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><=
span style=3D"border:0px;font-style:inherit;font-variant:inherit;font-weigh=
t:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-fami=
ly:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;marg=
in:0px;padding:0px;vertical-align:baseline;color:black"><br></span></p><p s=
tyle=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;f=
ont-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inh=
erit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-k=
erning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertica=
l-align:baseline;color:black"><b>Analyses Conducted:</b>=C2=A0=C2=A0</span>=
</p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"bord=
er:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-str=
etch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-seri=
f;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px=
;vertical-align:baseline;color:black">=C2=A0 =C2=A0</span></p><p style=3D"f=
ont-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style=
:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit;font=
-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:in=
herit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-align:b=
aseline;color:black">To resolve the problem, we have identified two workaro=
und solutions: =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px =
0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inherit;=
font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit=
;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:in=
herit;margin:0px;padding:0px;vertical-align:baseline;color:black">=C2=A0 =
=C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span =
style=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight:inh=
erit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-family:Ap=
tos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;margin:0p=
x;padding:0px;vertical-align:baseline;color:black"><b>Change of the hash pr=
otocol in the tunnels.</b>=C2=A0=C2=A0</span></p><p style=3D"font-weight:in=
herit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font=
-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;li=
ne-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-fe=
ature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;color=
:black">When we change the encryption algorithm from MD5 to SHA1, it works,=
 but after x days the problem reoccurs. (Not necessarily from MD5 to SHA1, =
but to any other). It is necessary to switch to an algorithm that is not cu=
rrently in use, meaning, if we switch back to MD5, it works. However, this =
solution is temporary. If we switch within a short period (1 hour to the pr=
evious), the problem persists, but if we switch after several days, the pro=
blem is temporarily resolved. =C2=A0</span></p><p style=3D"font-weight:inhe=
rit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-v=
ariant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line=
-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feat=
ure-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;color:b=
lack">=C2=A0 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0p=
x 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inherit;fo=
nt-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inherit;f=
ont-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:inhe=
rit;margin:0px;padding:0px;vertical-align:baseline;color:black"><b>Server r=
eboot.</b>=C2=A0=C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px=
 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inherit=
;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inheri=
t;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-settings:i=
nherit;margin:0px;padding:0px;vertical-align:baseline;color:black">The prob=
lem is only resolved by restarting the server, as merely restarting the ser=
vice is not sufficient. Even if after removing and reinstalling the xfrm ke=
rnel modules, the problem persists. =C2=A0</span></p><p style=3D"font-weigh=
t:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;=
font-variant:inherit;font-weight:inherit;font-stretch:inherit;font-size:11p=
t;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:inherit;fon=
t-feature-settings:inherit;margin:0px;padding:0px;vertical-align:baseline;c=
olor:black">=C2=A0 =C2=A0</span></p><p style=3D"font-weight:inherit;margin:=
0px 0px 8pt"><span style=3D"border:0px;font-style:inherit;font-variant:inhe=
rit;font-weight:inherit;font-stretch:inherit;font-size:11pt;line-height:inh=
erit;font-family:Aptos,sans-serif;font-kerning:inherit;font-feature-setting=
s:inherit;margin:0px;padding:0px;vertical-align:baseline;color:black">The f=
irewall rules have already been validated and are correct. =C2=A0</span></p=
><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:=
0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretc=
h:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;f=
ont-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;ve=
rtical-align:baseline;color:black">Even with the firewall open, the problem=
 persists, which means, with no rules in place. =C2=A0</span></p><p style=
=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-=
style:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit=
;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerni=
ng:inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-al=
ign:baseline;color:black">The firewall policy and the frm state are okay. =
=C2=A0</span></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span =
style=3D"border:0px;font-style:inherit;font-variant:inherit;font-weight:inh=
erit;font-stretch:inherit;font-size:11pt;line-height:inherit;font-family:Ap=
tos,sans-serif;font-kerning:inherit;font-feature-settings:inherit;margin:0p=
x;padding:0px;vertical-align:baseline;color:black">=C2=A0 =C2=A0</span></p>=
<p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0=
px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-stretch=
:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;fo=
nt-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:0px;ver=
tical-align:baseline;color:black"><b>Logs and Evidence is attached.</b></sp=
an></p><p style=3D"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"b=
order:0px;font-style:inherit;font-variant:inherit;font-weight:inherit;font-=
stretch:inherit;font-size:11pt;line-height:inherit;font-family:Aptos,sans-s=
erif;font-kerning:inherit;font-feature-settings:inherit;margin:0px;padding:=
0px;vertical-align:baseline;color:black">=C2=A0=C2=A0</span></p><p style=3D=
"font-weight:inherit;margin:0px 0px 8pt"><span style=3D"border:0px;font-sty=
le:inherit;font-variant:inherit;font-weight:inherit;font-stretch:inherit;fo=
nt-size:11pt;line-height:inherit;font-family:Aptos,sans-serif;font-kerning:=
inherit;font-feature-settings:inherit;margin:0px;padding:0px;vertical-align=
:baseline;color:black">Best regards,</span></p></span></div></div><div>Luca=
s<br></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div style=3D"font-size:small"><br></div></div></div></div></=
div></div></div></div>

--00000000000003d50a060c500f3f--
--00000000000003d50d060c500f41
Content-Type: text/plain; charset="US-ASCII"; name="XFRM_Concentrator.txt"
Content-Disposition: attachment; filename="XFRM_Concentrator.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lq2dlpae3>
X-Attachment-Id: f_lq2dlpae3

WGZybUluRXJyb3IgICAgICAgICAgICAgICAgICAgICA2NzQ1DQpYZnJtSW5CdWZmZXJFcnJvciAg
ICAgICAgICAgICAgIDANClhmcm1JbkhkckVycm9yICAgICAgICAgICAgICAgICAgMA0KWGZybUlu
Tm9TdGF0ZXMgICAgICAgICAgICAgICAgICAxODYxNzM2MA0KWGZybUluU3RhdGVQcm90b0Vycm9y
ICAgICAgICAgICA4OTINClhmcm1JblN0YXRlTW9kZUVycm9yICAgICAgICAgICAgMA0KWGZybUlu
U3RhdGVTZXFFcnJvciAgICAgICAgICAgICAxNjUxMjcxDQpYZnJtSW5TdGF0ZUV4cGlyZWQgICAg
ICAgICAgICAgIDANClhmcm1JblN0YXRlTWlzbWF0Y2ggICAgICAgICAgICAgMA0KWGZybUluU3Rh
dGVJbnZhbGlkICAgICAgICAgICAgICAxODUNClhmcm1JblRtcGxNaXNtYXRjaCAgICAgICAgICAg
ICAgMTg2MDkxODQNClhmcm1Jbk5vUG9scyAgICAgICAgICAgICAgICAgICAgNDEyDQpYZnJtSW5Q
b2xCbG9jayAgICAgICAgICAgICAgICAgIDANClhmcm1JblBvbEVycm9yICAgICAgICAgICAgICAg
ICAgMA0KWGZybU91dEVycm9yICAgICAgICAgICAgICAgICAgICAwDQpYZnJtT3V0QnVuZGxlR2Vu
RXJyb3IgICAgICAgICAgIDANClhmcm1PdXRCdW5kbGVDaGVja0Vycm9yICAgICAgICAgMA0KWGZy
bU91dE5vU3RhdGVzICAgICAgICAgICAgICAgICA2MjcyMTExDQpYZnJtT3V0U3RhdGVQcm90b0Vy
cm9yICAgICAgICAgIDYwODA5NjMNClhmcm1PdXRTdGF0ZU1vZGVFcnJvciAgICAgICAgICAgNzQ3
DQpYZnJtT3V0U3RhdGVTZXFFcnJvciAgICAgICAgICAgIDANClhmcm1PdXRTdGF0ZUV4cGlyZWQg
ICAgICAgICAgICAgMA0KWGZybU91dFBvbEJsb2NrICAgICAgICAgICAgICAgICAwDQpYZnJtT3V0
UG9sRGVhZCAgICAgICAgICAgICAgICAgIDANClhmcm1PdXRQb2xFcnJvciAgICAgICAgICAgICAg
ICAgMA0KWGZybUZ3ZEhkckVycm9yICAgICAgICAgICAgICAgICAyMzczOTQNClhmcm1PdXRTdGF0
ZUludmFsaWQgICAgICAgICAgICAgMA0KWGZybUFjcXVpcmVFcnJvciAgICAgICAgICAgICAgICAy
Njc2NzgNCg==
--00000000000003d50d060c500f41
Content-Type: text/plain; charset="US-ASCII"; name="TCPDump_Concentrator.txt"
Content-Disposition: attachment; filename="TCPDump_Concentrator.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lq2dlpai4>
X-Attachment-Id: f_lq2dlpai4

W3Jvb3RAYmIyazEzNzczOCBhZG1pbl0jIHRjcGR1bXAgLWkgYW55IGVzcCBhbmQgaG9zdCAxMC4x
MC41NS4xIC1lDQp0Y3BkdW1wOiB2ZXJib3NlIG91dHB1dCBzdXBwcmVzc2VkLCB1c2UgLXYgb3Ig
LXZ2IGZvciBmdWxsIHByb3RvY29sIGRlY29kZQ0KbGlzdGVuaW5nIG9uIGFueSwgbGluay10eXBl
IExJTlVYX1NMTCAoTGludXggY29va2VkKSwgY2FwdHVyZSBzaXplIDI2MjE0NCBieXRlcw0KMTE6
NTc6MDIuMDM3NDc3ICBJbiAwMDowNDpkZjo1YzpkZTpmOSAob3VpIFVua25vd24pIGV0aGVydHlw
ZSA4MDIuMVEgKDB4ODEwMCksIGxlbmd0aCAxNzY6IHZsYW4gMzUwLCBwIDAsIGV0aGVydHlwZSBJ
UHY0LCAxMC4xMC41NS4xID4gMTAuMTY1LjExMi4yNDg6IEVTUChzcGk9MHhjMDhhZTU0ZCxzZXE9
MHhiMDMpLCBsZW5ndGggMTM2DQoxMTo1NzowMi4wMzc0NzcgIEluIDAwOjA0OmRmOjVjOmRlOmY5
IChvdWkgVW5rbm93bikgZXRoZXJ0eXBlIDgwMi4xUSAoMHg4MTAwKSwgbGVuZ3RoIDE3Njogdmxh
biAzNTAsIHAgMCwgZXRoZXJ0eXBlIElQdjQsIDEwLjEwLjU1LjEgPiAxMC4xNjUuMTEyLjI0ODog
RVNQKHNwaT0weGMwOGFlNTRkLHNlcT0weGIwMyksIGxlbmd0aCAxMzYNCjExOjU3OjAyLjAzNzQ3
NyAgSW4gMDA6MDQ6ZGY6NWM6ZGU6ZjkgKG91aSBVbmtub3duKSBldGhlcnR5cGUgSVB2NCAoMHgw
ODAwKSwgbGVuZ3RoIDE3MjogMTAuMTAuNTUuMSA+IDEwLjE2NS4xMTIuMjQ4OiBFU1Aoc3BpPTB4
YzA4YWU1NGQsc2VxPTB4YjAzKSwgbGVuZ3RoIDEzNg0KMTE6NTc6MDMuMDYzOTg5ICBJbiAwMDow
NDpkZjo1YzpkZTpmOSAob3VpIFVua25vd24pIGV0aGVydHlwZSA4MDIuMVEgKDB4ODEwMCksIGxl
bmd0aCAxNzY6IHZsYW4gMzUwLCBwIDAsIGV0aGVydHlwZSBJUHY0LCAxMC4xMC41NS4xID4gMTAu
MTY1LjExMi4yNDg6IEVTUChzcGk9MHhjMDhhZTU0ZCxzZXE9MHhiMDQpLCBsZW5ndGggMTM2DQox
MTo1NzowMy4wNjM5ODkgIEluIDAwOjA0OmRmOjVjOmRlOmY5IChvdWkgVW5rbm93bikgZXRoZXJ0
eXBlIDgwMi4xUSAoMHg4MTAwKSwgbGVuZ3RoIDE3NjogdmxhbiAzNTAsIHAgMCwgZXRoZXJ0eXBl
IElQdjQsIDEwLjEwLjU1LjEgPiAxMC4xNjUuMTEyLjI0ODogRVNQKHNwaT0weGMwOGFlNTRkLHNl
cT0weGIwNCksIGxlbmd0aCAxMzYNCjExOjU3OjAzLjA2Mzk4OSAgSW4gMDA6MDQ6ZGY6NWM6ZGU6
ZjkgKG91aSBVbmtub3duKSBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDE3MjogMTAu
MTAuNTUuMSA+IDEwLjE2NS4xMTIuMjQ4OiBFU1Aoc3BpPTB4YzA4YWU1NGQsc2VxPTB4YjA0KSwg
bGVuZ3RoIDEzNg0KMTE6NTc6MDQuMDg4MDUyICBJbiAwMDowNDpkZjo1YzpkZTpmOSAob3VpIFVu
a25vd24pIGV0aGVydHlwZSA4MDIuMVEgKDB4ODEwMCksIGxlbmd0aCAxNzY6IHZsYW4gMzUwLCBw
IDAsIGV0aGVydHlwZSBJUHY0LCAxMC4xMC41NS4xID4gMTAuMTY1LjExMi4yNDg6IEVTUChzcGk9
MHhjMDhhZTU0ZCxzZXE9MHhiMDUpLCBsZW5ndGggMTM2DQoxMTo1NzowNC4wODgwNTIgIEluIDAw
OjA0OmRmOjVjOmRlOmY5IChvdWkgVW5rbm93bikgZXRoZXJ0eXBlIDgwMi4xUSAoMHg4MTAwKSwg
bGVuZ3RoIDE3NjogdmxhbiAzNTAsIHAgMCwgZXRoZXJ0eXBlIElQdjQsIDEwLjEwLjU1LjEgPiAx
MC4xNjUuMTEyLjI0ODogRVNQKHNwaT0weGMwOGFlNTRkLHNlcT0weGIwNSksIGxlbmd0aCAxMzYN
CjExOjU3OjA0LjA4ODA1MiAgSW4gMDA6MDQ6ZGY6NWM6ZGU6ZjkgKG91aSBVbmtub3duKSBldGhl
cnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDE3MjogMTAuMTAuNTUuMSA+IDEwLjE2NS4xMTIu
MjQ4OiBFU1Aoc3BpPTB4YzA4YWU1NGQsc2VxPTB4YjA1KSwgbGVuZ3RoIDEzNg0KMTE6NTc6MDUu
MTA5NjEzICBJbiAwMDowNDpkZjo1YzpkZTpmOSAob3VpIFVua25vd24pIGV0aGVydHlwZSA4MDIu
MVEgKDB4ODEwMCksIGxlbmd0aCAxNzY6IHZsYW4gMzUwLCBwIDAsIGV0aGVydHlwZSBJUHY0LCAx
MC4xMC41NS4xID4gMTAuMTY1LjExMi4yNDg6IEVTUChzcGk9MHhjMDhhZTU0ZCxzZXE9MHhiMDYp
LCBsZW5ndGggMTM2DQoxMTo1NzowNS4xMDk2MTMgIEluIDAwOjA0OmRmOjVjOmRlOmY5IChvdWkg
VW5rbm93bikgZXRoZXJ0eXBlIDgwMi4xUSAoMHg4MTAwKSwgbGVuZ3RoIDE3NjogdmxhbiAzNTAs
IHAgMCwgZXRoZXJ0eXBlIElQdjQsIDEwLjEwLjU1LjEgPiAxMC4xNjUuMTEyLjI0ODogRVNQKHNw
aT0weGMwOGFlNTRkLHNlcT0weGIwNiksIGxlbmd0aCAxMzYNCjExOjU3OjA1LjEwOTYxMyAgSW4g
MDA6MDQ6ZGY6NWM6ZGU6ZjkgKG91aSBVbmtub3duKSBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwg
bGVuZ3RoIDE3MjogMTAuMTAuNTUuMSA+IDEwLjE2NS4xMTIuMjQ4OiBFU1Aoc3BpPTB4YzA4YWU1
NGQsc2VxPTB4YjA2KSwgbGVuZ3RoIDEzNg0KMTE6NTc6MDYuMTMzNTAxICBJbiAwMDowNDpkZjo1
YzpkZTpmOSAob3VpIFVua25vd24pIGV0aGVydHlwZSA4MDIuMVEgKDB4ODEwMCksIGxlbmd0aCAx
NzY6IHZsYW4gMzUwLCBwIDAsIGV0aGVydHlwZSBJUHY0LCAxMC4xMC41NS4xID4gMTAuMTY1LjEx
Mi4yNDg6IEVTUChzcGk9MHhjMDhhZTU0ZCxzZXE9MHhiMDcpLCBsZW5ndGggMTM2DQoxMTo1Nzow
Ni4xMzM1MDEgIEluIDAwOjA0OmRmOjVjOmRlOmY5IChvdWkgVW5rbm93bikgZXRoZXJ0eXBlIDgw
Mi4xUSAoMHg4MTAwKSwgbGVuZ3RoIDE3NjogdmxhbiAzNTAsIHAgMCwgZXRoZXJ0eXBlIElQdjQs
IDEwLjEwLjU1LjEgPiAxMC4xNjUuMTEyLjI0ODogRVNQKHNwaT0weGMwOGFlNTRkLHNlcT0weGIw
NyksIGxlbmd0aCAxMzYNCjExOjU3OjA2LjEzMzUwMSAgSW4gMDA6MDQ6ZGY6NWM6ZGU6ZjkgKG91
aSBVbmtub3duKSBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDE3MjogMTAuMTAuNTUu
MSA+IDEwLjE2NS4xMTIuMjQ4OiBFU1Aoc3BpPTB4YzA4YWU1NGQsc2VxPTB4YjA3KSwgbGVuZ3Ro
IDEzNg0KMTE6NTc6MDcuMTU3NDMwICBJbiAwMDowNDpkZjo1YzpkZTpmOSAob3VpIFVua25vd24p
IGV0aGVydHlwZSA4MDIuMVEgKDB4ODEwMCksIGxlbmd0aCAxNzY6IHZsYW4gMzUwLCBwIDAsIGV0
aGVydHlwZSBJUHY0LCAxMC4xMC41NS4xID4gMTAuMTY1LjExMi4yNDg6IEVTUChzcGk9MHhjMDhh
ZTU0ZCxzZXE9MHhiMDgpLCBsZW5ndGggMTM2DQoxMTo1NzowNy4xNTc0MzAgIEluIDAwOjA0OmRm
OjVjOmRlOmY5IChvdWkgVW5rbm93bikgZXRoZXJ0eXBlIDgwMi4xUSAoMHg4MTAwKSwgbGVuZ3Ro
IDE3NjogdmxhbiAzNTAsIHAgMCwgZXRoZXJ0eXBlIElQdjQsIDEwLjEwLjU1LjEgPiAxMC4xNjUu
MTEyLjI0ODogRVNQKHNwaT0weGMwOGFlNTRkLHNlcT0weGIwOCksIGxlbmd0aCAxMzYNCjExOjU3
OjA3LjE1NzQzMCAgSW4gMDA6MDQ6ZGY6NWM6ZGU6ZjkgKG91aSBVbmtub3duKSBldGhlcnR5cGUg
SVB2NCAoMHgwODAwKSwgbGVuZ3RoIDE3MjogMTAuMTAuNTUuMSA+IDEwLjE2NS4xMTIuMjQ4OiBF
U1Aoc3BpPTB4YzA4YWU1NGQsc2VxPTB4YjA4KSwgbGVuZ3RoIDEzNg0KMTE6NTc6MDguMTgxNDk5
ICBJbiAwMDowNDpkZjo1YzpkZTpmOSAob3VpIFVua25vd24pIGV0aGVydHlwZSA4MDIuMVEgKDB4
ODEwMCksIGxlbmd0aCAxNzY6IHZsYW4gMzUwLCBwIDAsIGV0aGVydHlwZSBJUHY0LCAxMC4xMC41
NS4xID4gMTAuMTY1LjExMi4yNDg6IEVTUChzcGk9MHhjMDhhZTU0ZCxzZXE9MHhiMDkpLCBsZW5n
dGggMTM2DQoxMTo1NzowOC4xODE0OTkgIEluIDAwOjA0OmRmOjVjOmRlOmY5IChvdWkgVW5rbm93
bikgZXRoZXJ0eXBlIDgwMi4xUSAoMHg4MTAwKSwgbGVuZ3RoIDE3NjogdmxhbiAzNTAsIHAgMCwg
ZXRoZXJ0eXBlIElQdjQsIDEwLjEwLjU1LjEgPiAxMC4xNjUuMTEyLjI0ODogRVNQKHNwaT0weGMw
OGFlNTRkLHNlcT0weGIwOSksIGxlbmd0aCAxMzYNCjExOjU3OjA4LjE4MTQ5OSAgSW4gMDA6MDQ6
ZGY6NWM6ZGU6ZjkgKG91aSBVbmtub3duKSBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3Ro
IDE3MjogMTAuMTAuNTUuMSA+IDEwLjE2NS4xMTIuMjQ4OiBFU1Aoc3BpPTB4YzA4YWU1NGQsc2Vx
PTB4YjA5KSwgbGVuZ3RoIDEzNg0KMTE6NTc6MDkuMjA1NDk2ICBJbiAwMDowNDpkZjo1YzpkZTpm
OSAob3VpIFVua25vd24pIGV0aGVydHlwZSA4MDIuMVEgKDB4ODEwMCksIGxlbmd0aCAxNzY6IHZs
YW4gMzUwLCBwIDAsIGV0aGVydHlwZSBJUHY0LCAxMC4xMC41NS4xID4gMTAuMTY1LjExMi4yNDg6
IEVTUChzcGk9MHhjMDhhZTU0ZCxzZXE9MHhiMGEpLCBsZW5ndGggMTM2DQoxMTo1NzowOS4yMDU0
OTYgIEluIDAwOjA0OmRmOjVjOmRlOmY5IChvdWkgVW5rbm93bikgZXRoZXJ0eXBlIDgwMi4xUSAo
MHg4MTAwKSwgbGVuZ3RoIDE3NjogdmxhbiAzNTAsIHAgMCwgZXRoZXJ0eXBlIElQdjQsIDEwLjEw
LjU1LjEgPiAxMC4xNjUuMTEyLjI0ODogRVNQKHNwaT0weGMwOGFlNTRkLHNlcT0weGIwYSksIGxl
bmd0aCAxMzYNCjExOjU3OjA5LjIwNTQ5NiAgSW4gMDA6MDQ6ZGY6NWM6ZGU6ZjkgKG91aSBVbmtu
b3duKSBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDE3MjogMTAuMTAuNTUuMSA+IDEw
LjE2NS4xMTIuMjQ4OiBFU1Aoc3BpPTB4YzA4YWU1NGQsc2VxPTB4YjBhKSwgbGVuZ3RoIDEzNg0K
XkMNCjI0IHBhY2tldHMgY2FwdHVyZWQNCjMyMDAgcGFja2V0cyByZWNlaXZlZCBieSBmaWx0ZXIN
CjI5MTQgcGFja2V0cyBkcm9wcGVkIGJ5IGtlcm5lbA0K
--00000000000003d50d060c500f41
Content-Type: text/plain; charset="US-ASCII"; name="HW_info.txt"
Content-Disposition: attachment; filename="HW_info.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lq2dlp9m0>
X-Attachment-Id: f_lq2dlp9m0

IyBsc2NwdQ0KQXJjaGl0ZWN0dXJlOiAgICAgICAgICB4ODZfNjQNCkNQVSBvcC1tb2RlKHMpOiAg
ICAgICAgMzItYml0LCA2NC1iaXQNCkJ5dGUgT3JkZXI6ICAgICAgICAgICAgTGl0dGxlIEVuZGlh
bg0KQ1BVKHMpOiAgICAgICAgICAgICAgICA0MA0KT24tbGluZSBDUFUocykgbGlzdDogICAwLTM5
DQpUaHJlYWQocykgcGVyIGNvcmU6ICAgIDINCkNvcmUocykgcGVyIHNvY2tldDogICAgMTANClNv
Y2tldChzKTogICAgICAgICAgICAgMg0KTlVNQSBub2RlKHMpOiAgICAgICAgICAyDQpWZW5kb3Ig
SUQ6ICAgICAgICAgICAgIEdlbnVpbmVJbnRlbA0KQ1BVIGZhbWlseTogICAgICAgICAgICA2DQpN
b2RlbDogICAgICAgICAgICAgICAgIDg1DQpNb2RlbCBuYW1lOiAgICAgICAgICAgIEludGVsKFIp
IFhlb24oUikgU2lsdmVyIDQyMTBSIENQVSBAIDIuNDBHSHoNClN0ZXBwaW5nOiAgICAgICAgICAg
ICAgNw0KQ1BVIE1IejogICAgICAgICAgICAgICAyMzk5Ljk5MQ0KQ1BVIG1heCBNSHo6ICAgICAg
ICAgICAyNDAwLDAwMDANCkNQVSBtaW4gTUh6OiAgICAgICAgICAgMTAwMCwwMDAwDQpCb2dvTUlQ
UzogICAgICAgICAgICAgIDQ4MDAuMDANCkwxZCBjYWNoZTogICAgICAgICAgICAgMzJLDQpMMWkg
Y2FjaGU6ICAgICAgICAgICAgIDMySw0KTDIgY2FjaGU6ICAgICAgICAgICAgICAxMDI0Sw0KTDMg
Y2FjaGU6ICAgICAgICAgICAgICAxNDA4MEsNCk5VTUEgbm9kZTAgQ1BVKHMpOiAgICAgMC05LDIw
LTI5DQpOVU1BIG5vZGUxIENQVShzKTogICAgIDEwLTE5LDMwLTM5DQpGbGFnczogICAgICAgICAg
ICAgICAgIGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBw
Z2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIg
c3MgaHQgdG0gcGJlIHN5c2NhbGwgbnggcGRwZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFy
dCBhcmNoX3BlcmZtb24gcGVicyBidHMgcmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9uc3RvcF90
c2MgY3B1aWQgYXBlcmZtcGVyZiBwbmkgcGNsbXVscWRxIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCBz
bXggZXN0IHRtMiBzc3NlMyBzZGJnIGZtYSBjeDE2IHh0cHIgcGRjbSBwY2lkIGRjYSBzc2U0XzEg
c3NlNF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBh
dnggZjE2YyByZHJhbmQgbGFoZl9sbSBhYm0gM2Rub3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBlcGIg
Y2F0X2wzIGNkcF9sMyBpbnZwY2lkX3NpbmdsZSBzc2JkIG1iYSBpYnJzIGlicGIgc3RpYnAgaWJy
c19lbmhhbmNlZCBmc2dzYmFzZSB0c2NfYWRqdXN0IGJtaTEgaGxlIGF2eDIgc21lcCBibWkyIGVy
bXMgaW52cGNpZCBydG0gY3FtIG1weCByZHRfYSBhdng1MTJmIGF2eDUxMmRxIHJkc2VlZCBhZHgg
c21hcCBjbGZsdXNob3B0IGNsd2IgaW50ZWxfcHQgYXZ4NTEyY2QgYXZ4NTEyYncgYXZ4NTEydmwg
eHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVzIGNxbV9sbGMgY3FtX29jY3VwX2xsYyBjcW1f
bWJtX3RvdGFsIGNxbV9tYm1fbG9jYWwgZHRoZXJtIGFyYXQgcGxuIHB0cyBwa3Ugb3Nwa2UgYXZ4
NTEyX3ZubmkgbWRfY2xlYXIgZmx1c2hfbDFkIGFyY2hfY2FwYWJpbGl0aWVzDQoNCg0KDQpJbnRl
cmZhY2UgDQojIGV0aHRvb2wgLWkgZXRoOQ0KZHJpdmVyOiBpZ2INCnZlcnNpb246IDYuNC4xMS0z
LmVsNy54ODZfNjQNCmZpcm13YXJlLXZlcnNpb246IDEuNjMsIDB4ODAwMDA5ZmINCmV4cGFuc2lv
bi1yb20tdmVyc2lvbjoNCmJ1cy1pbmZvOiAwMDAwOjE4OjAwLjENCnN1cHBvcnRzLXN0YXRpc3Rp
Y3M6IHllcw0Kc3VwcG9ydHMtdGVzdDogeWVzDQpzdXBwb3J0cy1lZXByb20tYWNjZXNzOiB5ZXMN
CnN1cHBvcnRzLXJlZ2lzdGVyLWR1bXA6IHllcw0Kc3VwcG9ydHMtcHJpdi1mbGFnczogeWVzDQoN
Cg0KIyBsc3BjaQ0KMDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExh
a2UtRSBETUkzIFJlZ2lzdGVycyAocmV2IDA3KQ0KMDA6MDQuMCBTeXN0ZW0gcGVyaXBoZXJhbDog
SW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDQkRNQSBSZWdpc3RlcnMgKHJldiAwNykNCjAw
OjA0LjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0JE
TUEgUmVnaXN0ZXJzIChyZXYgMDcpDQowMDowNC4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBD
b3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENCRE1BIFJlZ2lzdGVycyAocmV2IDA3KQ0KMDA6MDQuMyBT
eXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDQkRNQSBSZWdp
c3RlcnMgKHJldiAwNykNCjAwOjA0LjQgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0
aW9uIFNreSBMYWtlLUUgQ0JETUEgUmVnaXN0ZXJzIChyZXYgMDcpDQowMDowNC41IFN5c3RlbSBw
ZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENCRE1BIFJlZ2lzdGVycyAo
cmV2IDA3KQ0KMDA6MDQuNiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5
IExha2UtRSBDQkRNQSBSZWdpc3RlcnMgKHJldiAwNykNCjAwOjA0LjcgU3lzdGVtIHBlcmlwaGVy
YWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0JETUEgUmVnaXN0ZXJzIChyZXYgMDcp
DQowMDowNS4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1F
IE1NL1Z0LWQgQ29uZmlndXJhdGlvbiBSZWdpc3RlcnMgKHJldiAwNykNCjAwOjA1LjIgU3lzdGVt
IHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDI1IChyZXYgMDcpDQowMDow
NS40IFBJQzogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwMjYgKHJldiAwNykNCjAwOjA4LjAg
U3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgVWJveCBSZWdp
c3RlcnMgKHJldiAwNykNCjAwOjA4LjEgUGVyZm9ybWFuY2UgY291bnRlcnM6IEludGVsIENvcnBv
cmF0aW9uIFNreSBMYWtlLUUgVWJveCBSZWdpc3RlcnMgKHJldiAwNykNCjAwOjA4LjIgU3lzdGVt
IHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgVWJveCBSZWdpc3RlcnMg
KHJldiAwNykNCjAwOjExLjAgVW5hc3NpZ25lZCBjbGFzcyBbZmYwMF06IEludGVsIENvcnBvcmF0
aW9uIEM2MjAgU2VyaWVzIENoaXBzZXQgRmFtaWx5IE1ST00gMCAocmV2IDA5KQ0KMDA6MTEuMSBV
bmFzc2lnbmVkIGNsYXNzIFtmZjAwXTogSW50ZWwgQ29ycG9yYXRpb24gQzYyMCBTZXJpZXMgQ2hp
cHNldCBGYW1pbHkgTVJPTSAxIChyZXYgMDkpDQowMDoxMS41IFNBVEEgY29udHJvbGxlcjogSW50
ZWwgQ29ycG9yYXRpb24gQzYyMCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgU1NBVEEgQ29udHJvbGxl
ciBbQUhDSSBtb2RlXSAocmV2IDA5KQ0KMDA6MTQuMCBVU0IgY29udHJvbGxlcjogSW50ZWwgQ29y
cG9yYXRpb24gQzYyMCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgVVNCIDMuMCB4SENJIENvbnRyb2xs
ZXIgKHJldiAwOSkNCjAwOjE0LjIgU2lnbmFsIHByb2Nlc3NpbmcgY29udHJvbGxlcjogSW50ZWwg
Q29ycG9yYXRpb24gQzYyMCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgVGhlcm1hbCBTdWJzeXN0ZW0g
KHJldiAwOSkNCjAwOjE2LjAgQ29tbXVuaWNhdGlvbiBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBDNjIwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBNRUkgQ29udHJvbGxlciAjMSAocmV2IDA5
KQ0KMDA6MTYuNCBDb21tdW5pY2F0aW9uIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIEM2
MjAgU2VyaWVzIENoaXBzZXQgRmFtaWx5IE1FSSBDb250cm9sbGVyICMzIChyZXYgMDkpDQowMDox
Ny4wIFNBVEEgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gQzYyMCBTZXJpZXMgQ2hpcHNl
dCBGYW1pbHkgU0FUQSBDb250cm9sbGVyIFtBSENJIG1vZGVdIChyZXYgMDkpDQowMDoxYy4wIFBD
SSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIEM2MjAgU2VyaWVzIENoaXBzZXQgRmFtaWx5IFBD
SSBFeHByZXNzIFJvb3QgUG9ydCAjMSAocmV2IGY5KQ0KMDA6MWMuNCBQQ0kgYnJpZGdlOiBJbnRl
bCBDb3Jwb3JhdGlvbiBDNjIwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBQQ0kgRXhwcmVzcyBSb290
IFBvcnQgIzUgKHJldiBmOSkNCjAwOjFjLjUgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24g
QzYyMCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgUENJIEV4cHJlc3MgUm9vdCBQb3J0ICM2IChyZXYg
ZjkpDQowMDoxZi4wIElTQSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIEM2MjQgU2VyaWVzIENo
aXBzZXQgTFBDL2VTUEkgQ29udHJvbGxlciAocmV2IDA5KQ0KMDA6MWYuMiBNZW1vcnkgY29udHJv
bGxlcjogSW50ZWwgQ29ycG9yYXRpb24gQzYyMCBTZXJpZXMgQ2hpcHNldCBGYW1pbHkgUG93ZXIg
TWFuYWdlbWVudCBDb250cm9sbGVyIChyZXYgMDkpDQowMDoxZi40IFNNQnVzOiBJbnRlbCBDb3Jw
b3JhdGlvbiBDNjIwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBTTUJ1cyAocmV2IDA5KQ0KMDA6MWYu
NSBTZXJpYWwgYnVzIGNvbnRyb2xsZXIgWzBjODBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBDNjIwIFNl
cmllcyBDaGlwc2V0IEZhbWlseSBTUEkgQ29udHJvbGxlciAocmV2IDA5KQ0KMDE6MDAuMCBQQ0kg
YnJpZGdlOiBBU1BFRUQgVGVjaG5vbG9neSwgSW5jLiBBU1QxMTUwIFBDSS10by1QQ0kgQnJpZGdl
IChyZXYgMDQpDQowMjowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEFTUEVFRCBUZWNo
bm9sb2d5LCBJbmMuIEFTUEVFRCBHcmFwaGljcyBGYW1pbHkgKHJldiA0MSkNCjAzOjAwLjAgRXRo
ZXJuZXQgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gSTIxMCBHaWdhYml0IE5ldHdvcmsg
Q29ubmVjdGlvbiAocmV2IDAzKQ0KMDQ6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyOiBJbnRlbCBD
b3Jwb3JhdGlvbiBJMjEwIEdpZ2FiaXQgTmV0d29yayBDb25uZWN0aW9uIChyZXYgMDMpDQoxNzow
MC4wIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgUENJIEV4cHJlc3Mg
Um9vdCBQb3J0IEEgKHJldiAwNykNCjE3OjAxLjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRp
b24gU2t5IExha2UtRSBQQ0kgRXhwcmVzcyBSb290IFBvcnQgQiAocmV2IDA3KQ0KMTc6MDUuMCBT
eXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwMzQgKHJldiAwNykN
CjE3OjA1LjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUg
UkFTIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXJzIChyZXYgMDcpDQoxNzowNS40IFBJQzogSW50ZWwg
Q29ycG9yYXRpb24gRGV2aWNlIDIwMzYgKHJldiAwNykNCjE3OjA4LjAgU3lzdGVtIHBlcmlwaGVy
YWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0K
MTc6MDguMSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBD
SEEgUmVnaXN0ZXJzIChyZXYgMDcpDQoxNzowOC4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBD
b3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjE3OjA4LjMgU3lz
dGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVy
cyAocmV2IDA3KQ0KMTc6MDguNCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24g
U2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQoxNzowOC41IFN5c3RlbSBwZXJpcGhl
cmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykN
CjE3OjA4LjYgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUg
Q0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KMTc6MDguNyBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwg
Q29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQoxNzowOS4wIFN5
c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3Rl
cnMgKHJldiAwNykNCjE3OjA5LjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9u
IFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KMTc6MGUuMCBTeXN0ZW0gcGVyaXBo
ZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcp
DQoxNzowZS4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1F
IENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjE3OjBlLjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVs
IENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KMTc6MGUuMyBT
eXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0
ZXJzIChyZXYgMDcpDQoxNzowZS40IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlv
biBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjE3OjBlLjUgU3lzdGVtIHBlcmlw
aGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3
KQ0KMTc6MGUuNiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2Ut
RSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQoxNzowZS43IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRl
bCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjE3OjBmLjAg
U3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lz
dGVycyAocmV2IDA3KQ0KMTc6MGYuMSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRp
b24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQoxNzoxZC4wIFN5c3RlbSBwZXJp
cGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAw
NykNCjE3OjFkLjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtl
LUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KMTc6MWQuMiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50
ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQoxNzoxZC4z
IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdp
c3RlcnMgKHJldiAwNykNCjE3OjFlLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0
aW9uIFNreSBMYWtlLUUgUENVIFJlZ2lzdGVycyAocmV2IDA3KQ0KMTc6MWUuMSBTeXN0ZW0gcGVy
aXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBQQ1UgUmVnaXN0ZXJzIChyZXYg
MDcpDQoxNzoxZS4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFr
ZS1FIFBDVSBSZWdpc3RlcnMgKHJldiAwNykNCjE3OjFlLjMgU3lzdGVtIHBlcmlwaGVyYWw6IElu
dGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgUENVIFJlZ2lzdGVycyAocmV2IDA3KQ0KMTc6MWUu
NCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBQQ1UgUmVn
aXN0ZXJzIChyZXYgMDcpDQoxNzoxZS41IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBTa3kgTGFrZS1FIFBDVSBSZWdpc3RlcnMgKHJldiAwNykNCjE3OjFlLjYgU3lzdGVtIHBl
cmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgUENVIFJlZ2lzdGVycyAocmV2
IDA3KQ0KMTg6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBJMzUw
IEdpZ2FiaXQgTmV0d29yayBDb25uZWN0aW9uIChyZXYgMDEpDQoxODowMC4xIEV0aGVybmV0IGNv
bnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIEkzNTAgR2lnYWJpdCBOZXR3b3JrIENvbm5lY3Rp
b24gKHJldiAwMSkNCjE4OjAwLjIgRXRoZXJuZXQgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRp
b24gSTM1MCBHaWdhYml0IE5ldHdvcmsgQ29ubmVjdGlvbiAocmV2IDAxKQ0KMTg6MDAuMyBFdGhl
cm5ldCBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBJMzUwIEdpZ2FiaXQgTmV0d29yayBD
b25uZWN0aW9uIChyZXYgMDEpDQoxOTowMC4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IEludGVsIENv
cnBvcmF0aW9uIEkzNTAgR2lnYWJpdCBOZXR3b3JrIENvbm5lY3Rpb24gKHJldiAwMSkNCjE5OjAw
LjEgRXRoZXJuZXQgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gSTM1MCBHaWdhYml0IE5l
dHdvcmsgQ29ubmVjdGlvbiAocmV2IDAxKQ0KMTk6MDAuMiBFdGhlcm5ldCBjb250cm9sbGVyOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBJMzUwIEdpZ2FiaXQgTmV0d29yayBDb25uZWN0aW9uIChyZXYgMDEp
DQoxOTowMC4zIEV0aGVybmV0IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIEkzNTAgR2ln
YWJpdCBOZXR3b3JrIENvbm5lY3Rpb24gKHJldiAwMSkNCjNhOjA1LjAgU3lzdGVtIHBlcmlwaGVy
YWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDM0IChyZXYgMDcpDQozYTowNS4yIFN5c3Rl
bSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIFJBUyBDb25maWd1cmF0
aW9uIFJlZ2lzdGVycyAocmV2IDA3KQ0KM2E6MDUuNCBQSUM6IEludGVsIENvcnBvcmF0aW9uIERl
dmljZSAyMDM2IChyZXYgMDcpDQozYTowOC4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jw
b3JhdGlvbiBEZXZpY2UgMjA2NiAocmV2IDA3KQ0KM2E6MDkuMCBTeXN0ZW0gcGVyaXBoZXJhbDog
SW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNjYgKHJldiAwNykNCjNhOjBhLjAgU3lzdGVtIHBl
cmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQwIChyZXYgMDcpDQozYTowYS4x
IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0MSAocmV2IDA3
KQ0KM2E6MGEuMiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIw
NDIgKHJldiAwNykNCjNhOjBhLjMgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9u
IERldmljZSAyMDQzIChyZXYgMDcpDQozYTowYS40IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBD
b3Jwb3JhdGlvbiBEZXZpY2UgMjA0NCAocmV2IDA3KQ0KM2E6MGEuNSBTeXN0ZW0gcGVyaXBoZXJh
bDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNDUgKHJldiAwNykNCjNhOjBhLjYgU3lzdGVt
IHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQ2IChyZXYgMDcpDQozYTow
YS43IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0NyAocmV2
IDA3KQ0KM2E6MGIuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNl
IDIwNDggKHJldiAwNykNCjNhOjBiLjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0
aW9uIERldmljZSAyMDQ5IChyZXYgMDcpDQozYTowYi4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRl
bCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0YSAocmV2IDA3KQ0KM2E6MGIuMyBTeXN0ZW0gcGVyaXBo
ZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNGIgKHJldiAwNykNCjNhOjBjLjAgU3lz
dGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQwIChyZXYgMDcpDQoz
YTowYy4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0MSAo
cmV2IDA3KQ0KM2E6MGMuMiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2
aWNlIDIwNDIgKHJldiAwNykNCjNhOjBjLjMgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBv
cmF0aW9uIERldmljZSAyMDQzIChyZXYgMDcpDQozYTowYy40IFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0NCAocmV2IDA3KQ0KM2E6MGMuNSBTeXN0ZW0gcGVy
aXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNDUgKHJldiAwNykNCjNhOjBjLjYg
U3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQ2IChyZXYgMDcp
DQozYTowYy43IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0
NyAocmV2IDA3KQ0KM2E6MGQuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24g
RGV2aWNlIDIwNDggKHJldiAwNykNCjNhOjBkLjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENv
cnBvcmF0aW9uIERldmljZSAyMDQ5IChyZXYgMDcpDQozYTowZC4yIFN5c3RlbSBwZXJpcGhlcmFs
OiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0YSAocmV2IDA3KQ0KM2E6MGQuMyBTeXN0ZW0g
cGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNGIgKHJldiAwNykNCjVkOjA1
LjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDM0IChyZXYg
MDcpDQo1ZDowNS4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFr
ZS1FIFJBUyBDb25maWd1cmF0aW9uIFJlZ2lzdGVycyAocmV2IDA3KQ0KNWQ6MDUuNCBQSUM6IElu
dGVsIENvcnBvcmF0aW9uIERldmljZSAyMDM2IChyZXYgMDcpDQo1ZDowZS4wIFBlcmZvcm1hbmNl
IGNvdW50ZXJzOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA1OCAocmV2IDA3KQ0KNWQ6MGUu
MSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNTkgKHJldiAw
NykNCjVkOjBmLjAgUGVyZm9ybWFuY2UgY291bnRlcnM6IEludGVsIENvcnBvcmF0aW9uIERldmlj
ZSAyMDU4IChyZXYgMDcpDQo1ZDowZi4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBEZXZpY2UgMjA1OSAocmV2IDA3KQ0KNWQ6MTIuMCBQZXJmb3JtYW5jZSBjb3VudGVyczog
SW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBNM0tUSSBSZWdpc3RlcnMgKHJldiAwNykNCjVk
OjEyLjEgUGVyZm9ybWFuY2UgY291bnRlcnM6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUg
TTNLVEkgUmVnaXN0ZXJzIChyZXYgMDcpDQo1ZDoxMi4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRl
bCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIE0zS1RJIFJlZ2lzdGVycyAocmV2IDA3KQ0KNWQ6MTUu
MCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBNMlBDSSBS
ZWdpc3RlcnMgKHJldiAwNykNCjVkOjE1LjEgUGVyZm9ybWFuY2UgY291bnRlcnM6IEludGVsIENv
cnBvcmF0aW9uIERldmljZSAyMDg4IChyZXYgMDcpDQo1ZDoxNi4wIFN5c3RlbSBwZXJpcGhlcmFs
OiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIE0yUENJIFJlZ2lzdGVycyAocmV2IDA3KQ0K
NWQ6MTYuMSBQZXJmb3JtYW5jZSBjb3VudGVyczogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIw
ODggKHJldiAwNykNCjVkOjE2LjQgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9u
IFNreSBMYWtlLUUgTTJQQ0kgUmVnaXN0ZXJzIChyZXYgMDcpDQo1ZDoxNi41IFBlcmZvcm1hbmNl
IGNvdW50ZXJzOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA4OCAocmV2IDA3KQ0KODA6MDQu
MCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDQkRNQSBS
ZWdpc3RlcnMgKHJldiAwNykNCjgwOjA0LjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBv
cmF0aW9uIFNreSBMYWtlLUUgQ0JETUEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4MDowNC4yIFN5c3Rl
bSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENCRE1BIFJlZ2lzdGVy
cyAocmV2IDA3KQ0KODA6MDQuMyBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24g
U2t5IExha2UtRSBDQkRNQSBSZWdpc3RlcnMgKHJldiAwNykNCjgwOjA0LjQgU3lzdGVtIHBlcmlw
aGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0JETUEgUmVnaXN0ZXJzIChyZXYg
MDcpDQo4MDowNC41IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFr
ZS1FIENCRE1BIFJlZ2lzdGVycyAocmV2IDA3KQ0KODA6MDQuNiBTeXN0ZW0gcGVyaXBoZXJhbDog
SW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDQkRNQSBSZWdpc3RlcnMgKHJldiAwNykNCjgw
OjA0LjcgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0JE
TUEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4MDowNS4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBD
b3Jwb3JhdGlvbiBTa3kgTGFrZS1FIE1NL1Z0LWQgQ29uZmlndXJhdGlvbiBSZWdpc3RlcnMgKHJl
diAwNykNCjgwOjA1LjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmlj
ZSAyMDI1IChyZXYgMDcpDQo4MDowNS40IFBJQzogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIw
MjYgKHJldiAwNykNCjgwOjA4LjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9u
IFNreSBMYWtlLUUgVWJveCBSZWdpc3RlcnMgKHJldiAwNykNCjgwOjA4LjEgUGVyZm9ybWFuY2Ug
Y291bnRlcnM6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgVWJveCBSZWdpc3RlcnMgKHJl
diAwNykNCjgwOjA4LjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBM
YWtlLUUgVWJveCBSZWdpc3RlcnMgKHJldiAwNykNCjg1OjA1LjAgU3lzdGVtIHBlcmlwaGVyYWw6
IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDM0IChyZXYgMDcpDQo4NTowNS4yIFN5c3RlbSBw
ZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIFJBUyBDb25maWd1cmF0aW9u
IFJlZ2lzdGVycyAocmV2IDA3KQ0KODU6MDUuNCBQSUM6IEludGVsIENvcnBvcmF0aW9uIERldmlj
ZSAyMDM2IChyZXYgMDcpDQo4NTowOC4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjg1OjA4LjEgU3lzdGVtIHBl
cmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2
IDA3KQ0KODU6MDguMiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExh
a2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4NTowOC4zIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjg1OjA4
LjQgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJl
Z2lzdGVycyAocmV2IDA3KQ0KODU6MDguNSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9y
YXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4NTowOC42IFN5c3RlbSBw
ZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJl
diAwNykNCjg1OjA4LjcgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBM
YWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KODU6MDkuMCBTeXN0ZW0gcGVyaXBoZXJhbDog
SW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4NTow
OS4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBS
ZWdpc3RlcnMgKHJldiAwNykNCjg1OjBlLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBv
cmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KODU6MGUuMSBTeXN0ZW0g
cGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChy
ZXYgMDcpDQo4NTowZS4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kg
TGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjg1OjBlLjMgU3lzdGVtIHBlcmlwaGVyYWw6
IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KODU6
MGUuNCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEg
UmVnaXN0ZXJzIChyZXYgMDcpDQo4NTowZS41IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jw
b3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjg1OjBlLjYgU3lzdGVt
IHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAo
cmV2IDA3KQ0KODU6MGUuNyBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5
IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4NTowZi4wIFN5c3RlbSBwZXJpcGhlcmFs
OiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMgKHJldiAwNykNCjg1
OjBmLjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgQ0hB
IFJlZ2lzdGVycyAocmV2IDA3KQ0KODU6MWQuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29y
cG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4NToxZC4xIFN5c3Rl
bSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIENIQSBSZWdpc3RlcnMg
KHJldiAwNykNCjg1OjFkLjIgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIFNr
eSBMYWtlLUUgQ0hBIFJlZ2lzdGVycyAocmV2IDA3KQ0KODU6MWQuMyBTeXN0ZW0gcGVyaXBoZXJh
bDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBDSEEgUmVnaXN0ZXJzIChyZXYgMDcpDQo4
NToxZS4wIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIFBD
VSBSZWdpc3RlcnMgKHJldiAwNykNCjg1OjFlLjEgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENv
cnBvcmF0aW9uIFNreSBMYWtlLUUgUENVIFJlZ2lzdGVycyAocmV2IDA3KQ0KODU6MWUuMiBTeXN0
ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBQQ1UgUmVnaXN0ZXJz
IChyZXYgMDcpDQo4NToxZS4zIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBT
a3kgTGFrZS1FIFBDVSBSZWdpc3RlcnMgKHJldiAwNykNCjg1OjFlLjQgU3lzdGVtIHBlcmlwaGVy
YWw6IEludGVsIENvcnBvcmF0aW9uIFNreSBMYWtlLUUgUENVIFJlZ2lzdGVycyAocmV2IDA3KQ0K
ODU6MWUuNSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBQ
Q1UgUmVnaXN0ZXJzIChyZXYgMDcpDQo4NToxZS42IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBD
b3Jwb3JhdGlvbiBTa3kgTGFrZS1FIFBDVSBSZWdpc3RlcnMgKHJldiAwNykNCmFlOjA1LjAgU3lz
dGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDM0IChyZXYgMDcpDQph
ZTowNS4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIFJB
UyBDb25maWd1cmF0aW9uIFJlZ2lzdGVycyAocmV2IDA3KQ0KYWU6MDUuNCBQSUM6IEludGVsIENv
cnBvcmF0aW9uIERldmljZSAyMDM2IChyZXYgMDcpDQphZTowOC4wIFN5c3RlbSBwZXJpcGhlcmFs
OiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA2NiAocmV2IDA3KQ0KYWU6MDkuMCBTeXN0ZW0g
cGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNjYgKHJldiAwNykNCmFlOjBh
LjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQwIChyZXYg
MDcpDQphZTowYS4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2Ug
MjA0MSAocmV2IDA3KQ0KYWU6MGEuMiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRp
b24gRGV2aWNlIDIwNDIgKHJldiAwNykNCmFlOjBhLjMgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVs
IENvcnBvcmF0aW9uIERldmljZSAyMDQzIChyZXYgMDcpDQphZTowYS40IFN5c3RlbSBwZXJpcGhl
cmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0NCAocmV2IDA3KQ0KYWU6MGEuNSBTeXN0
ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNDUgKHJldiAwNykNCmFl
OjBhLjYgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQ2IChy
ZXYgMDcpDQphZTowYS43IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZp
Y2UgMjA0NyAocmV2IDA3KQ0KYWU6MGIuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9y
YXRpb24gRGV2aWNlIDIwNDggKHJldiAwNykNCmFlOjBiLjEgU3lzdGVtIHBlcmlwaGVyYWw6IElu
dGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQ5IChyZXYgMDcpDQphZTowYi4yIFN5c3RlbSBwZXJp
cGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0YSAocmV2IDA3KQ0KYWU6MGIuMyBT
eXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNGIgKHJldiAwNykN
CmFlOjBjLjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQw
IChyZXYgMDcpDQphZTowYy4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBE
ZXZpY2UgMjA0MSAocmV2IDA3KQ0KYWU6MGMuMiBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29y
cG9yYXRpb24gRGV2aWNlIDIwNDIgKHJldiAwNykNCmFlOjBjLjMgU3lzdGVtIHBlcmlwaGVyYWw6
IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQzIChyZXYgMDcpDQphZTowYy40IFN5c3RlbSBw
ZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0NCAocmV2IDA3KQ0KYWU6MGMu
NSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNDUgKHJldiAw
NykNCmFlOjBjLjYgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAy
MDQ2IChyZXYgMDcpDQphZTowYy43IFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlv
biBEZXZpY2UgMjA0NyAocmV2IDA3KQ0KYWU6MGQuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwg
Q29ycG9yYXRpb24gRGV2aWNlIDIwNDggKHJldiAwNykNCmFlOjBkLjEgU3lzdGVtIHBlcmlwaGVy
YWw6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDQ5IChyZXYgMDcpDQphZTowZC4yIFN5c3Rl
bSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA0YSAocmV2IDA3KQ0KYWU6
MGQuMyBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNlIDIwNGIgKHJl
diAwNykNCmQ3OjA1LjAgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVsIENvcnBvcmF0aW9uIERldmlj
ZSAyMDM0IChyZXYgMDcpDQpkNzowNS4yIFN5c3RlbSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBTa3kgTGFrZS1FIFJBUyBDb25maWd1cmF0aW9uIFJlZ2lzdGVycyAocmV2IDA3KQ0KZDc6
MDUuNCBQSUM6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDM2IChyZXYgMDcpDQpkNzowZS4w
IFBlcmZvcm1hbmNlIGNvdW50ZXJzOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA1OCAocmV2
IDA3KQ0KZDc6MGUuMSBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gRGV2aWNl
IDIwNTkgKHJldiAwNykNCmQ3OjBmLjAgUGVyZm9ybWFuY2UgY291bnRlcnM6IEludGVsIENvcnBv
cmF0aW9uIERldmljZSAyMDU4IChyZXYgMDcpDQpkNzowZi4xIFN5c3RlbSBwZXJpcGhlcmFsOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA1OSAocmV2IDA3KQ0KZDc6MTIuMCBQZXJmb3JtYW5j
ZSBjb3VudGVyczogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExha2UtRSBNM0tUSSBSZWdpc3RlcnMg
KHJldiAwNykNCmQ3OjEyLjEgUGVyZm9ybWFuY2UgY291bnRlcnM6IEludGVsIENvcnBvcmF0aW9u
IFNreSBMYWtlLUUgTTNLVEkgUmVnaXN0ZXJzIChyZXYgMDcpDQpkNzoxMi4yIFN5c3RlbSBwZXJp
cGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIE0zS1RJIFJlZ2lzdGVycyAocmV2
IDA3KQ0KZDc6MTUuMCBTeXN0ZW0gcGVyaXBoZXJhbDogSW50ZWwgQ29ycG9yYXRpb24gU2t5IExh
a2UtRSBNMlBDSSBSZWdpc3RlcnMgKHJldiAwNykNCmQ3OjE1LjEgUGVyZm9ybWFuY2UgY291bnRl
cnM6IEludGVsIENvcnBvcmF0aW9uIERldmljZSAyMDg4IChyZXYgMDcpDQpkNzoxNi4wIFN5c3Rl
bSBwZXJpcGhlcmFsOiBJbnRlbCBDb3Jwb3JhdGlvbiBTa3kgTGFrZS1FIE0yUENJIFJlZ2lzdGVy
cyAocmV2IDA3KQ0KZDc6MTYuMSBQZXJmb3JtYW5jZSBjb3VudGVyczogSW50ZWwgQ29ycG9yYXRp
b24gRGV2aWNlIDIwODggKHJldiAwNykNCmQ3OjE2LjQgU3lzdGVtIHBlcmlwaGVyYWw6IEludGVs
IENvcnBvcmF0aW9uIFNreSBMYWtlLUUgTTJQQ0kgUmVnaXN0ZXJzIChyZXYgMDcpDQpkNzoxNi41
IFBlcmZvcm1hbmNlIGNvdW50ZXJzOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgMjA4OCAocmV2
IDA3KQ0KDQoNCg0K
--00000000000003d50d060c500f41
Content-Type: text/plain; charset="US-ASCII"; name="lsmod.txt"
Content-Disposition: attachment; filename="lsmod.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lq2dlpa11>
X-Attachment-Id: f_lq2dlpa11

TW9kdWxlICAgICAgICAgICAgICAgICAgU2l6ZSAgVXNlZCBieQpiaW5mbXRfbWlzYyAgICAgICAg
ICAgIDI0NTc2ICAxIAplY2hhaW5pdiAgICAgICAgICAgICAgIDEyMjg4ICA0MDggCmVzcDQgICAg
ICAgICAgICAgICAgICAgMjg2NzIgIDQwOCAKeHRfYWRkcnR5cGUgICAgICAgICAgICAxMjI4OCAg
MiAKeHRfbmF0ICAgICAgICAgICAgICAgICAxMjI4OCAgNSAKeHRfVENQTVNTICAgICAgICAgICAg
ICAxMjI4OCAgNiAKeHRfZGV2Z3JvdXAgICAgICAgICAgICAxMjI4OCAgNjEgCnh0X05GTE9HICAg
ICAgICAgICAgICAgMTIyODggIDUyIAp4dF9oYXNobGltaXQgICAgICAgICAgIDIwNDgwICA1MiAK
YXV0aGVuYyAgICAgICAgICAgICAgICAxMjI4OCAgNDA4IAppcF9zZXRfaGFzaF9uZXQgICAgICAg
IDQ5MTUyICAxNCAKY3J5cHRvX3VzZXIgICAgICAgICAgICAxMjI4OCAgMCAKeHRfQ1QgICAgICAg
ICAgICAgICAgICAxMjI4OCAgOCAKeHRfUkVESVJFQ1QgICAgICAgICAgICAxNjM4NCAgNCAKeHRf
bXVsdGlwb3J0ICAgICAgICAgICAxNjM4NCAgNiAKeGZybV9pbnRlcmZhY2UgICAgICAgICAyNDU3
NiAgMCAKeGZybTZfdHVubmVsICAgICAgICAgICAxNjM4NCAgMSB4ZnJtX2ludGVyZmFjZQp0dW5u
ZWw2ICAgICAgICAgICAgICAgIDEyMjg4ICAyIHhmcm1faW50ZXJmYWNlLHhmcm02X3R1bm5lbAp0
dW5uZWw0ICAgICAgICAgICAgICAgIDEyMjg4ICAxIHhmcm1faW50ZXJmYWNlCnR3b2Zpc2hfZ2Vu
ZXJpYyAgICAgICAgMTYzODQgIDAgCnR3b2Zpc2hfYXZ4X3g4Nl82NCAgICAgNDkxNTIgIDAgCnR3
b2Zpc2hfeDg2XzY0XzN3YXkgICAgMzI3NjggIDEgdHdvZmlzaF9hdnhfeDg2XzY0CnR3b2Zpc2hf
eDg2XzY0ICAgICAgICAgMTYzODQgIDIgdHdvZmlzaF94ODZfNjRfM3dheSx0d29maXNoX2F2eF94
ODZfNjQKdHdvZmlzaF9jb21tb24gICAgICAgICAyMDQ4MCAgNCB0d29maXNoX3g4Nl82NCx0d29m
aXNoX2dlbmVyaWMsdHdvZmlzaF94ODZfNjRfM3dheSx0d29maXNoX2F2eF94ODZfNjQKc2VycGVu
dF9hdnhfeDg2XzY0ICAgICA0OTE1MiAgMCAKc2VycGVudF9zc2UyX3g4Nl82NCAgICA0OTE1MiAg
MCAKc2VycGVudF9nZW5lcmljICAgICAgICAyNDU3NiAgMiBzZXJwZW50X3NzZTJfeDg2XzY0LHNl
cnBlbnRfYXZ4X3g4Nl82NApjYXN0NV9hdnhfeDg2XzY0ICAgICAgIDUzMjQ4ICAwIApjYXN0NV9n
ZW5lcmljICAgICAgICAgIDIwNDgwICAxIGNhc3Q1X2F2eF94ODZfNjQKY2FzdF9jb21tb24gICAg
ICAgICAgICAxMjI4OCAgMiBjYXN0NV9nZW5lcmljLGNhc3Q1X2F2eF94ODZfNjQKZGVzX2dlbmVy
aWMgICAgICAgICAgICAxMjI4OCAgNDA4IApsaWJkZXMgICAgICAgICAgICAgICAgIDIwNDgwICAx
IGRlc19nZW5lcmljCmNhbWVsbGlhX2dlbmVyaWMgICAgICAgMjg2NzIgIDAgCmlwNnRhYmxlX25h
dCAgICAgICAgICAgMTIyODggIDEgCmlwNnRhYmxlX21hbmdsZSAgICAgICAgMTIyODggIDEgCmlw
NnRhYmxlX3JhdyAgICAgICAgICAgMTIyODggIDEgCmlwNnRhYmxlX2ZpbHRlciAgICAgICAgMTIy
ODggIDEgCmlwNl90YWJsZXMgICAgICAgICAgICAgMzI3NjggIDQgaXA2dGFibGVfZmlsdGVyLGlw
NnRhYmxlX3JhdyxpcDZ0YWJsZV9uYXQsaXA2dGFibGVfbWFuZ2xlCmNhbWVsbGlhX3g4Nl82NCAg
ICAgICAgNTczNDQgIDAgCnhjYmMgICAgICAgICAgICAgICAgICAgMTIyODggIDAgCm1kNCAgICAg
ICAgICAgICAgICAgICAgMTIyODggIDAgCnh0X01BU1FVRVJBREUgICAgICAgICAgMTYzODQgIDQg
Cnh0X2Nvbm50cmFjayAgICAgICAgICAgMTIyODggIDcwIAp4dF9zZXQgICAgICAgICAgICAgICAg
IDIwNDgwICAzMSAKaXBfc2V0X2hhc2hfaXAgICAgICAgICA0NTA1NiAgMyAKaXBfc2V0ICAgICAg
ICAgICAgICAgICA1NzM0NCAgMyBpcF9zZXRfaGFzaF9pcCx4dF9zZXQsaXBfc2V0X2hhc2hfbmV0
Cnh0X2Nvbm5tYXJrICAgICAgICAgICAgMTIyODggIDcwIAp4dF9tYXJrICAgICAgICAgICAgICAg
IDEyMjg4ICA5OSAKcGNyeXB0ICAgICAgICAgICAgICAgICAxMjI4OCAgNDA4IAppcHRhYmxlX25h
dCAgICAgICAgICAgIDEyMjg4ICAxIAppcHRhYmxlX21hbmdsZSAgICAgICAgIDEyMjg4ICAxIApp
cHRhYmxlX3JhdyAgICAgICAgICAgIDEyMjg4ICAxIAppcF92cyAgICAgICAgICAgICAgICAgMjAw
NzA0ICAwIAppcHRhYmxlX2ZpbHRlciAgICAgICAgIDEyMjg4ICAxIApicl9uZXRmaWx0ZXIgICAg
ICAgICAgIDMyNzY4ICAwIApuZl9uYXRfZnRwICAgICAgICAgICAgIDE2Mzg0ICAwIApuZl9jb25u
dHJhY2tfZnRwICAgICAgIDIwNDgwICAxIG5mX25hdF9mdHAKbmZfbmF0X3NpcCAgICAgICAgICAg
ICAxNjM4NCAgMCAKbmZfY29ubnRyYWNrX3NpcCAgICAgICA0MDk2MCAgMSBuZl9uYXRfc2lwCm5m
X25hdF90ZnRwICAgICAgICAgICAgMTIyODggIDAgCm5mX2Nvbm50cmFja190ZnRwICAgICAgMjA0
ODAgIDEgbmZfbmF0X3RmdHAKbmZfbmF0X2gzMjMgICAgICAgICAgICAyNDU3NiAgMCAKbmZfY29u
bnRyYWNrX2gzMjMgICAgICA3NzgyNCAgMSBuZl9uYXRfaDMyMwpuZl9uYXRfcHB0cCAgICAgICAg
ICAgIDE2Mzg0ICAwIApuZl9jb25udHJhY2tfcHB0cCAgICAgIDI0NTc2ICAxIG5mX25hdF9wcHRw
Cm5mX25hdCAgICAgICAgICAgICAgICAgNTczNDQgIDEwIGlwNnRhYmxlX25hdCxuZl9uYXRfZnRw
LHh0X25hdCxuZl9uYXRfdGZ0cCxuZl9uYXRfcHB0cCxuZl9uYXRfaDMyMyxpcHRhYmxlX25hdCx4
dF9NQVNRVUVSQURFLG5mX25hdF9zaXAseHRfUkVESVJFQ1QKODAyMXEgICAgICAgICAgICAgICAg
ICA0NTA1NiAgMCAKZ2FycCAgICAgICAgICAgICAgICAgICAxNjM4NCAgMSA4MDIxcQptcnAgICAg
ICAgICAgICAgICAgICAgIDIwNDgwICAxIDgwMjFxCmlwX2dyZSAgICAgICAgICAgICAgICAgMzI3
NjggIDAgCmlwX3R1bm5lbCAgICAgICAgICAgICAgMzI3NjggIDEgaXBfZ3JlCmdyZSAgICAgICAg
ICAgICAgICAgICAgMTIyODggIDEgaXBfZ3JlCm5mX2Nvbm50cmFja19uZXRsaW5rICAgIDUzMjQ4
ICAwIApuZm5ldGxpbmtfbG9nICAgICAgICAgIDIwNDgwICA1MyAKbmZfY29ubnRyYWNrICAgICAg
ICAgIDE4NDMyMCAgMTkgeHRfY29ubnRyYWNrLG5mX25hdCxuZl9jb25udHJhY2tfdGZ0cCxuZl9u
YXRfZnRwLG5mX2Nvbm50cmFja19wcHRwLHh0X25hdCxuZl9uYXRfdGZ0cCxuZl9jb25udHJhY2tf
c2lwLG5mX2Nvbm50cmFja19oMzIzLG5mX25hdF9wcHRwLG5mX2Nvbm50cmFja19uZXRsaW5rLHh0
X2Nvbm5tYXJrLG5mX2Nvbm50cmFja19mdHAseHRfQ1QsbmZfbmF0X2gzMjMseHRfTUFTUVVFUkFE
RSxuZl9uYXRfc2lwLGlwX3ZzLHh0X1JFRElSRUNUCm5mX2RlZnJhZ19pcHY2ICAgICAgICAgMjQ1
NzYgIDIgbmZfY29ubnRyYWNrLGlwX3ZzCm5mX2RlZnJhZ19pcHY0ICAgICAgICAgMTIyODggIDEg
bmZfY29ubnRyYWNrCmxpYmNyYzMyYyAgICAgICAgICAgICAgMTIyODggIDMgbmZfY29ubnRyYWNr
LG5mX25hdCxpcF92cwpuZm5ldGxpbmsgICAgICAgICAgICAgIDIwNDgwICAxMSBuZl9jb25udHJh
Y2tfbmV0bGluayxpcF9zZXQsbmZuZXRsaW5rX2xvZwp4dHMgICAgICAgICAgICAgICAgICAgIDEy
Mjg4ICAyIAppbnRlbF9yYXBsX2NvbW1vbiAgICAgIDMyNzY4ICAwIAppbnRlbF91bmNvcmVfZnJl
cXVlbmN5ICAgIDEyMjg4ICAwIAppbnRlbF91bmNvcmVfZnJlcXVlbmN5X2NvbW1vbiAgICAxMjI4
OCAgMSBpbnRlbF91bmNvcmVfZnJlcXVlbmN5Cmlzc3RfaWZfY29tbW9uICAgICAgICAgMjA0ODAg
IDAgCnNreF9lZGFjICAgICAgICAgICAgICAgMjA0ODAgIDAgCm5maXQgICAgICAgICAgICAgICAg
ICAgNzM3MjggIDEgc2t4X2VkYWMKeDg2X3BrZ190ZW1wX3RoZXJtYWwgICAgMTYzODQgIDAgCmlu
dGVsX3Bvd2VyY2xhbXAgICAgICAgMTYzODQgIDAgCmNvcmV0ZW1wICAgICAgICAgICAgICAgMTYz
ODQgIDAgCnBwZGV2ICAgICAgICAgICAgICAgICAgMjQ1NzYgIDIgCmlUQ09fd2R0ICAgICAgICAg
ICAgICAgMTIyODggIDAgCmlUQ09fdmVuZG9yX3N1cHBvcnQgICAgMTIyODggIDEgaVRDT193ZHQK
cmFwbCAgICAgICAgICAgICAgICAgICAyMDQ4MCAgMCAKaW50ZWxfY3N0YXRlICAgICAgICAgICAy
MDQ4MCAgMCAKcGNzcGtyICAgICAgICAgICAgICAgICAxMjI4OCAgMCAKam95ZGV2ICAgICAgICAg
ICAgICAgICAyNDU3NiAgMCAKaW5wdXRfbGVkcyAgICAgICAgICAgICAxMjI4OCAgMCAKc2cgICAg
ICAgICAgICAgICAgICAgICA0NTA1NiAgMCAKaTJjX2k4MDEgICAgICAgICAgICAgICAzNjg2NCAg
MCAKbWVpX21lICAgICAgICAgICAgICAgICA1MzI0OCAgMCAKbHBjX2ljaCAgICAgICAgICAgICAg
ICAyNDU3NiAgMCAKaTJjX3NtYnVzICAgICAgICAgICAgICAyMDQ4MCAgMSBpMmNfaTgwMQptZmRf
Y29yZSAgICAgICAgICAgICAgIDEyMjg4ICAxIGxwY19pY2gKbWVpICAgICAgICAgICAgICAgICAg
IDE1OTc0NCAgMSBtZWlfbWUKaW50ZWxfcGNoX3RoZXJtYWwgICAgICAxNjM4NCAgMCAKYWNwaV9p
cG1pICAgICAgICAgICAgICAxNjM4NCAgMCAKcGFycG9ydF9wYyAgICAgICAgICAgICA0MDk2MCAg
MSAKaXBtaV9zaSAgICAgICAgICAgICAgICA3NzgyNCAgMSAKaXBtaV9kZXZpbnRmICAgICAgICAg
ICAxNjM4NCAgMCAKcGFycG9ydCAgICAgICAgICAgICAgICA3MzcyOCAgMiBwYXJwb3J0X3BjLHBw
ZGV2CmlwbWlfbXNnaGFuZGxlciAgICAgICAgNzc4MjQgIDMgaXBtaV9kZXZpbnRmLGlwbWlfc2ks
YWNwaV9pcG1pCmlvYXRkbWEgICAgICAgICAgICAgICAgNjE0NDAgIDAgCnRjcF9odGNwICAgICAg
ICAgICAgICAgMTIyODggIDI5IAppcF90YWJsZXMgICAgICAgICAgICAgIDMyNzY4ICA0IGlwdGFi
bGVfZmlsdGVyLGlwdGFibGVfcmF3LGlwdGFibGVfbmF0LGlwdGFibGVfbWFuZ2xlCmV4dDQgICAg
ICAgICAgICAgICAgICA5NTQzNjggIDQgCm1iY2FjaGUgICAgICAgICAgICAgICAgMTYzODQgIDEg
ZXh0NApqYmQyICAgICAgICAgICAgICAgICAgMTY3OTM2ICAxIGV4dDQKZG1fY3J5cHQgICAgICAg
ICAgICAgICA1MzI0OCAgNSAKYmxvd2Zpc2hfZ2VuZXJpYyAgICAgICAxMjI4OCAgMCAKYmxvd2Zp
c2hfeDg2XzY0ICAgICAgICAyNDU3NiAgMyAKYmxvd2Zpc2hfY29tbW9uICAgICAgICAxNjM4NCAg
MiBibG93ZmlzaF9nZW5lcmljLGJsb3dmaXNoX3g4Nl82NApzZF9tb2QgICAgICAgICAgICAgICAg
IDc3ODI0ICA1IAp0MTBfcGkgICAgICAgICAgICAgICAgIDE2Mzg0ICAxIHNkX21vZApjcmM2NF9y
b2Nrc29mdF9nZW5lcmljICAgIDEyMjg4ICAxIApjcmM2NF9yb2Nrc29mdCAgICAgICAgIDE2Mzg0
ICAxIHQxMF9waQpjcmM2NCAgICAgICAgICAgICAgICAgIDE2Mzg0ICAyIGNyYzY0X3JvY2tzb2Z0
LGNyYzY0X3JvY2tzb2Z0X2dlbmVyaWMKY3JjdDEwZGlmX3BjbG11bCAgICAgICAxMjI4OCAgMSAK
Y3JjMzJfcGNsbXVsICAgICAgICAgICAxMjI4OCAgMCAKY3JjMzJjX2ludGVsICAgICAgICAgICAx
NjM4NCAgNSAKYXN0ICAgICAgICAgICAgICAgICAgICA3MzcyOCAgMCAKcG9seXZhbF9jbG11bG5p
ICAgICAgICAxMjI4OCAgMCAKcG9seXZhbF9nZW5lcmljICAgICAgICAxMjI4OCAgMSBwb2x5dmFs
X2NsbXVsbmkKZHJtX3NobWVtX2hlbHBlciAgICAgICAyNDU3NiAgMSBhc3QKZ2hhc2hfY2xtdWxu
aV9pbnRlbCAgICAxNjM4NCAgMCAKc2hhNTEyX3Nzc2UzICAgICAgICAgICA0OTE1MiAgMSAKZHJt
X2ttc19oZWxwZXIgICAgICAgIDIyNTI4MCAgMyBhc3QKY3J5cHRvX3NpbWQgICAgICAgICAgICAx
NjM4NCAgNCBzZXJwZW50X3NzZTJfeDg2XzY0LHNlcnBlbnRfYXZ4X3g4Nl82NCxjYXN0NV9hdnhf
eDg2XzY0LHR3b2Zpc2hfYXZ4X3g4Nl82NApzeXNjb3B5YXJlYSAgICAgICAgICAgIDEyMjg4ICAx
IGRybV9rbXNfaGVscGVyCnN5c2ZpbGxyZWN0ICAgICAgICAgICAgMTIyODggIDEgZHJtX2ttc19o
ZWxwZXIKY3J5cHRkICAgICAgICAgICAgICAgICAyNDU3NiAgMiBjcnlwdG9fc2ltZCxnaGFzaF9j
bG11bG5pX2ludGVsCnNlcmlvX3JhdyAgICAgICAgICAgICAgMTYzODQgIDAgCmFoY2kgICAgICAg
ICAgICAgICAgICAgNDkxNTIgIDUgCnN5c2ltZ2JsdCAgICAgICAgICAgICAgMTIyODggIDEgZHJt
X2ttc19oZWxwZXIKY2RjX2V0aGVyICAgICAgICAgICAgICAyNDU3NiAgMCAKaWdiICAgICAgICAg
ICAgICAgICAgIDI3NDQzMiAgMCAKbGliYWhjaSAgICAgICAgICAgICAgICA1MzI0OCAgMSBhaGNp
CmRjYSAgICAgICAgICAgICAgICAgICAgMTYzODQgIDIgaWdiLGlvYXRkbWEKdXNibmV0ICAgICAg
ICAgICAgICAgICA2MTQ0MCAgMSBjZGNfZXRoZXIKbWlpICAgICAgICAgICAgICAgICAgICAyMDQ4
MCAgMSB1c2JuZXQKcHRwICAgICAgICAgICAgICAgICAgICAzNjg2NCAgMSBpZ2IKZHJtICAgICAg
ICAgICAgICAgICAgIDY0MzA3MiAgNCBkcm1fa21zX2hlbHBlcixhc3QsZHJtX3NobWVtX2hlbHBl
cgpwcHNfY29yZSAgICAgICAgICAgICAgIDI0NTc2ICAxIHB0cAppMmNfYWxnb19iaXQgICAgICAg
ICAgIDEyMjg4ICAyIGlnYixhc3QKd21pICAgICAgICAgICAgICAgICAgICAzNjg2NCAgMCAKbGli
YXRhICAgICAgICAgICAgICAgIDM5NzMxMiAgMiBsaWJhaGNpLGFoY2kKc3VucnBjICAgICAgICAg
ICAgICAgIDcwODYwOCAgMSAKZG1fbWlycm9yICAgICAgICAgICAgICAyNDU3NiAgMCAKZG1fcmVn
aW9uX2hhc2ggICAgICAgICAyNDU3NiAgMSBkbV9taXJyb3IKZG1fbG9nICAgICAgICAgICAgICAg
ICAyMDQ4MCAgMiBkbV9yZWdpb25faGFzaCxkbV9taXJyb3IKZG1fbW9kICAgICAgICAgICAgICAg
IDE4NDMyMCAgMTQgZG1fY3J5cHQsZG1fbG9nLGRtX21pcnJvcgpmdXNlICAgICAgICAgICAgICAg
ICAgMTgwMjI0ICAxIApkZWZsYXRlICAgICAgICAgICAgICAgIDE2Mzg0ICAxIAo=
--00000000000003d50d060c500f41
Content-Type: text/plain; charset="US-ASCII"; name="proc-crypto.txt"
Content-Disposition: attachment; filename="proc-crypto.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lq2dlpa72>
X-Attachment-Id: f_lq2dlpa72

bmFtZSAgICAgICAgIDogZWNoYWluaXYoYXV0aGVuYyhobWFjKHNoYTEpLGNiYyhkZXMzX2VkZSkp
KQpkcml2ZXIgICAgICAgOiBlY2hhaW5pdihwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTEtZ2VuZXJp
YyksY2JjKGRlczNfZWRlLWdlbmVyaWMpKSkpCm1vZHVsZSAgICAgICA6IGVjaGFpbml2CnByaW9y
aXR5ICAgICA6IDEyMDAKcmVmY250ICAgICAgIDogNDEwCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpi
bG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMjAKZ2VuaXYg
ICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxjdHIo
Y2FzdDUpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTUxMi1hdngyKSxj
dHIoY2FzdDUtZ2VuZXJpYykpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDog
MTI3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAg
OiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAg
OiAxCml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogNjQKZ2VuaXYgICAgICAgIDogPG5v
bmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxjdHIoY2FzdDUpKQpkcml2
ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyLWF2eDIpLGN0cihjYXN0NS1nZW5lcmljKSkK
bW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAxMTcwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4
Cm1heGF1dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDog
YXV0aGVuYyhobWFjKHNoYTM4NCksY3RyKGNhc3Q1KSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1
dGhlbmMoaG1hYyhzaGEzODQtYXZ4MiksY3RyKGNhc3Q1LWdlbmVyaWMpKSkKbW9kdWxlICAgICAg
IDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDEyNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAg
ICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXpl
ICA6IDQ4Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFj
KHNoYTM4NCksY3RyKGNhc3Q1KSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4NC1h
dngyKSxjdHIoY2FzdDUtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkg
ICAgIDogMTE3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5h
bCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6
ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAgICAgICAg
OiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGN0cihjYXN0NSkp
CmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMjU2LWdlbmVyaWMpLGN0cihj
YXN0NS1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMjAw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEK
aXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAzMgpnZW5pdiAgICAgICAgOiA8bm9uZT4K
Cm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGN0cihjYXN0NSkpCmRyaXZlciAg
ICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYtZ2VuZXJpYyksY3RyKGNhc3Q1LWdlbmVyaWMpKQpt
b2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDExMDAKcmVmY250ICAgICAgIDog
MQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDog
YWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgK
bWF4YXV0aHNpemUgIDogMzIKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBh
dXRoZW5jKGhtYWMoc2hhMSksY3RyKGNhc3Q1KSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhl
bmMoaG1hYyhzaGExLWdlbmVyaWMpLGN0cihjYXN0NS1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6
IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMjAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAg
IDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAg
ICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAg
OiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhz
aGExKSxjdHIoY2FzdDUpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMS1nZW5lcmlj
KSxjdHIoY2FzdDUtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAg
IDogMTEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAg
ICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAg
ICA6IDEKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8
bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGN0cihjYXN0NSkpCmRyaXZl
ciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMobWQ1LWdlbmVyaWMpLGN0cihjYXN0NS1nZW5l
cmljKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMTAwCnJlZmNudCAg
ICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAg
ICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAg
ICAgIDogOAptYXhhdXRoc2l6ZSAgOiAxNgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAg
ICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGN0cihjYXN0NSkpCmRyaXZlciAgICAgICA6IGF1dGhl
bmMoaG1hYyhtZDUtZ2VuZXJpYyksY3RyKGNhc3Q1LWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBh
dXRoZW5jCnByaW9yaXR5ICAgICA6IDEwMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAg
OiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAg
ICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDog
MTYKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBjdHIoY2FzdDUpCmRyaXZl
ciAgICAgICA6IGN0cihjYXN0NS1nZW5lcmljKQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3Jp
dHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVy
bmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJs
b2Nrc2l6ZSAgICA6IDEKbWluIGtleXNpemUgIDogNQptYXgga2V5c2l6ZSAgOiAxNgppdnNpemUg
ICAgICAgOiA4CmNodW5rc2l6ZSAgICA6IDgKd2Fsa3NpemUgICAgIDogOAoKbmFtZSAgICAgICAg
IDogYXV0aGVuYyhobWFjKHNoYTUxMiksY3RyKGNhbWVsbGlhKSkKZHJpdmVyICAgICAgIDogcGNy
eXB0KGF1dGhlbmMoaG1hYyhzaGE1MTItYXZ4MiksY3RyKGNhbWVsbGlhLWFzbSkpKQptb2R1bGUg
ICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMjI3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFz
eW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDE2Cm1heGF1
dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVu
YyhobWFjKHNoYTUxMiksY3RyKGNhbWVsbGlhKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFj
KHNoYTUxMi1hdngyKSxjdHIoY2FtZWxsaWEtYXNtKSkKbW9kdWxlICAgICAgIDogYXV0aGVuYwpw
cmlvcml0eSAgICAgOiAyMTcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2Vk
CmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogbm8K
YmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiA2NApnZW5p
diAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQpLGN0
cihjYW1lbGxpYSkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMzg0LWF2
eDIpLGN0cihjYW1lbGxpYS1hc20pKSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAg
ICA6IDIyNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwg
ICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXpl
ICAgIDogMQppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAgICAgICAg
OiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQpLGN0cihjYW1lbGxp
YSkpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQtYXZ4MiksY3RyKGNhbWVsbGlh
LWFzbSkpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMjE3MApyZWZjbnQg
ICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAg
ICAgIDogMTYKbWF4YXV0aHNpemUgIDogNDgKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAg
ICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMjU2KSxjdHIoY2FtZWxsaWEpKQpkcml2ZXIgICAgICAg
OiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTI1Ni1nZW5lcmljKSxjdHIoY2FtZWxsaWEtYXNtKSkp
Cm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAyMjAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDog
MTYKbWF4YXV0aHNpemUgIDogMzIKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAg
OiBhdXRoZW5jKGhtYWMoc2hhMjU2KSxjdHIoY2FtZWxsaWEpKQpkcml2ZXIgICAgICAgOiBhdXRo
ZW5jKGhtYWMoc2hhMjU2LWdlbmVyaWMpLGN0cihjYW1lbGxpYS1hc20pKQptb2R1bGUgICAgICAg
OiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDIxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAg
ICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDE2Cm1heGF1dGhzaXpl
ICA6IDMyCmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFj
KHNoYTEpLGN0cihjYW1lbGxpYSkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMo
c2hhMS1nZW5lcmljKSxjdHIoY2FtZWxsaWEtYXNtKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApw
cmlvcml0eSAgICAgOiAyMjAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2Vk
CmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVz
CmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDogMjAKZ2Vu
aXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMSksY3Ry
KGNhbWVsbGlhKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTEtZ2VuZXJpYyksY3Ry
KGNhbWVsbGlhLWFzbSkpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMjEw
MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBu
bwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEK
aXZzaXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDogMjAKZ2VuaXYgICAgICAgIDogPG5vbmU+
CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1KSxjdHIoY2FtZWxsaWEpKQpkcml2ZXIg
ICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKG1kNS1nZW5lcmljKSxjdHIoY2FtZWxsaWEtYXNt
KSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAyMTAwCnJlZmNudCAgICAg
ICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAg
ICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAg
IDogMTYKbWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAg
ICAgOiBhdXRoZW5jKGhtYWMobWQ1KSxjdHIoY2FtZWxsaWEpKQpkcml2ZXIgICAgICAgOiBhdXRo
ZW5jKGhtYWMobWQ1LWdlbmVyaWMpLGN0cihjYW1lbGxpYS1hc20pKQptb2R1bGUgICAgICAgOiBh
dXRoZW5jCnByaW9yaXR5ICAgICA6IDIwMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAg
OiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAg
ICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDE2Cm1heGF1dGhzaXplICA6
IDE2Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNo
YTUxMiksY3RyKGJsb3dmaXNoKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhz
aGE1MTItYXZ4MiksY3RyKGJsb3dmaXNoLWFzbSkpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJp
b3JpdHkgICAgIDogMjI3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpi
bG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogNjQKZ2VuaXYg
ICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxjdHIo
Ymxvd2Zpc2gpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyLWF2eDIpLGN0cihi
bG93ZmlzaC1hc20pKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDIxNzAK
cmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8K
dHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2
c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogNjQKZ2VuaXYgICAgICAgIDogPG5vbmU+Cgpu
YW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMzg0KSxjdHIoYmxvd2Zpc2gpKQpkcml2ZXIg
ICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTM4NC1hdngyKSxjdHIoYmxvd2Zpc2gtYXNt
KSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAyMjcwCnJlZmNudCAgICAg
ICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAg
ICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAg
IDogOAptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAg
ICA6IGF1dGhlbmMoaG1hYyhzaGEzODQpLGN0cihibG93ZmlzaCkpCmRyaXZlciAgICAgICA6IGF1
dGhlbmMoaG1hYyhzaGEzODQtYXZ4MiksY3RyKGJsb3dmaXNoLWFzbSkpCm1vZHVsZSAgICAgICA6
IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMjE3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAg
ICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAg
ICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAg
OiA0OApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhz
aGEyNTYpLGN0cihibG93ZmlzaCkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMo
c2hhMjU2LWdlbmVyaWMpLGN0cihibG93ZmlzaC1hc20pKSkKbW9kdWxlICAgICAgIDogcGNyeXB0
CnByaW9yaXR5ICAgICA6IDIyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNz
ZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5
ZXMKYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDMyCmdl
bml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTI1Niks
Y3RyKGJsb3dmaXNoKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTI1Ni1nZW5lcmlj
KSxjdHIoYmxvd2Zpc2gtYXNtKSkKbW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAg
OiAyMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAg
ICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAg
IDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDMyCmdlbml2ICAgICAgICA6IDxu
b25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTEpLGN0cihibG93ZmlzaCkpCmRy
aXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMS1nZW5lcmljKSxjdHIoYmxvd2Zp
c2gtYXNtKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAyMjAwCnJlZmNu
dCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUg
ICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXpl
ICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUg
ICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGExKSxjdHIoYmxvd2Zpc2gpKQpkcml2ZXIgICAgICAg
OiBhdXRoZW5jKGhtYWMoc2hhMS1nZW5lcmljKSxjdHIoYmxvd2Zpc2gtYXNtKSkKbW9kdWxlICAg
ICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAyMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRl
c3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5
bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhz
aXplICA6IDIwCmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyho
bWFjKG1kNSksY3RyKGJsb3dmaXNoKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1h
YyhtZDUtZ2VuZXJpYyksY3RyKGJsb3dmaXNoLWFzbSkpKQptb2R1bGUgICAgICAgOiBwY3J5cHQK
cHJpb3JpdHkgICAgIDogMjEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3Nl
ZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHll
cwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMTYKZ2Vu
aXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1KSxjdHIo
Ymxvd2Zpc2gpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1LWdlbmVyaWMpLGN0cihi
bG93ZmlzaC1hc20pKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDIwMDAK
cmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8K
dHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2
c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAgIDogPG5vbmU+Cgpu
YW1lICAgICAgICAgOiBjdHIoYmxvd2Zpc2gpCmRyaXZlciAgICAgICA6IGN0cihibG93ZmlzaC1h
c20pCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAg
IDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQptaW4ga2V5c2l6
ZSAgOiA0Cm1heCBrZXlzaXplICA6IDU2Cml2c2l6ZSAgICAgICA6IDgKY2h1bmtzaXplICAgIDog
OAp3YWxrc2l6ZSAgICAgOiA4CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxj
dHIoYWVzKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhzaGE1MTItYXZ4Miks
Y3RyKGFlcy1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAx
MjcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6
IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6
IDEKaXZzaXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDogNjQKZ2VuaXYgICAgICAgIDogPG5v
bmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxjdHIoYWVzKSkKZHJpdmVy
ICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTUxMi1hdngyKSxjdHIoYWVzLWdlbmVyaWMpKQptb2R1
bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDExNzAKcmVmY250ICAgICAgIDogMQpz
ZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVh
ZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDE2Cm1h
eGF1dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0
aGVuYyhobWFjKHNoYTM4NCksY3RyKGFlcykpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5j
KGhtYWMoc2hhMzg0LWF2eDIpLGN0cihhZXMtZ2VuZXJpYykpKQptb2R1bGUgICAgICAgOiBwY3J5
cHQKcHJpb3JpdHkgICAgIDogMTI3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBh
c3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6
IHllcwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDE2Cm1heGF1dGhzaXplICA6IDQ4
Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4
NCksY3RyKGFlcykpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQtYXZ4MiksY3Ry
KGFlcy1nZW5lcmljKSkKbW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAxMTcw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQpp
dnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAgICAgICAgOiA8bm9uZT4K
Cm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGN0cihhZXMpKQpkcml2ZXIgICAg
ICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTI1Ni1nZW5lcmljKSxjdHIoYWVzLWdlbmVyaWMp
KSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDEyMDAKcmVmY250ICAgICAg
IDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAg
OiAxNgptYXhhdXRoc2l6ZSAgOiAzMgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAg
ICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGN0cihhZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5j
KGhtYWMoc2hhMjU2LWdlbmVyaWMpLGN0cihhZXMtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1
dGhlbmMKcHJpb3JpdHkgICAgIDogMTEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAg
ICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDog
MzIKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hh
MSksY3RyKGFlcykpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMS1nZW5l
cmljKSxjdHIoYWVzLWdlbmVyaWMpKSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAg
ICA6IDEyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwg
ICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXpl
ICAgIDogMQppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAg
OiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGExKSxjdHIoYWVzKSkKZHJp
dmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTEtZ2VuZXJpYyksY3RyKGFlcy1nZW5lcmljKSkK
bW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAxMTAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiAx
NgptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6
IGF1dGhlbmMoaG1hYyhtZDUpLGN0cihhZXMpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVu
YyhobWFjKG1kNS1nZW5lcmljKSxjdHIoYWVzLWdlbmVyaWMpKSkKbW9kdWxlICAgICAgIDogcGNy
eXB0CnByaW9yaXR5ICAgICA6IDExMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBw
YXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAg
OiB5ZXMKYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiAx
NgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUp
LGN0cihhZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1LWdlbmVyaWMpLGN0cihh
ZXMtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMTAwMApy
ZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0
eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKaXZz
aXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAgIDogPG5vbmU+Cgpu
YW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxjdHIoZGVzM19lZGUpKQpkcml2ZXIg
ICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTUxMi1hdngyKSxjdHIoZGVzM19lZGUtZ2Vu
ZXJpYykpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMTI3MApyZWZjbnQg
ICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAg
ICAgICA6IDgKbWF4YXV0aHNpemUgIDogNjQKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAg
ICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxjdHIoZGVzM19lZGUpKQpkcml2ZXIgICAgICAg
OiBhdXRoZW5jKGhtYWMoc2hhNTEyLWF2eDIpLGN0cihkZXMzX2VkZS1nZW5lcmljKSkKbW9kdWxl
ICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAxMTcwCnJlZmNudCAgICAgICA6IDEKc2Vs
ZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQK
YXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1
dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVu
YyhobWFjKHNoYTM4NCksY3RyKGRlczNfZWRlKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhl
bmMoaG1hYyhzaGEzODQtYXZ4MiksY3RyKGRlczNfZWRlLWdlbmVyaWMpKSkKbW9kdWxlICAgICAg
IDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDEyNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAg
ICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXpl
ICA6IDQ4Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFj
KHNoYTM4NCksY3RyKGRlczNfZWRlKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4
NC1hdngyKSxjdHIoZGVzM19lZGUtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJp
b3JpdHkgICAgIDogMTE3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJs
b2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAg
ICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGN0cihk
ZXMzX2VkZSkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMjU2LWdlbmVy
aWMpLGN0cihkZXMzX2VkZS1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0
eSAgICAgOiAxMjAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVy
bmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nr
c2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAzMgpnZW5pdiAgICAg
ICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGN0cihkZXMz
X2VkZSkpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYtZ2VuZXJpYyksY3RyKGRl
czNfZWRlLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDEx
MDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDog
bm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAx
Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMzIKZ2VuaXYgICAgICAgIDogPG5vbmU+
CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMSksY3RyKGRlczNfZWRlKSkKZHJpdmVy
ICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhzaGExLWdlbmVyaWMpLGN0cihkZXMzX2VkZS1n
ZW5lcmljKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMjAwCnJlZmNu
dCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUg
ICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXpl
ICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUg
ICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGExKSxjdHIoZGVzM19lZGUpKQpkcml2ZXIgICAgICAg
OiBhdXRoZW5jKGhtYWMoc2hhMS1nZW5lcmljKSxjdHIoZGVzM19lZGUtZ2VuZXJpYykpCm1vZHVs
ZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMTEwMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFk
CmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhh
dXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhl
bmMoaG1hYyhtZDUpLGN0cihkZXMzX2VkZSkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5j
KGhtYWMobWQ1LWdlbmVyaWMpLGN0cihkZXMzX2VkZS1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6
IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAg
IDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAg
ICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAg
OiAxNgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyht
ZDUpLGN0cihkZXMzX2VkZSkpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUtZ2VuZXJp
YyksY3RyKGRlczNfZWRlLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5
ICAgICA6IDEwMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3Np
emUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAg
IDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBjdHIoZGVzM19lZGUpCmRyaXZlciAgICAgICA6IGN0
cihkZXMzX2VkZS1nZW5lcmljKQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDog
MTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6
IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAg
ICA6IDEKbWluIGtleXNpemUgIDogMjQKbWF4IGtleXNpemUgIDogMjQKaXZzaXplICAgICAgIDog
OApjaHVua3NpemUgICAgOiA4CndhbGtzaXplICAgICA6IDgKCm5hbWUgICAgICAgICA6IGF1dGhl
bmMoaG1hYyhzaGE1MTIpLGN0cihkZXMpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyho
bWFjKHNoYTUxMi1hdngyKSxjdHIoZGVzLWdlbmVyaWMpKSkKbW9kdWxlICAgICAgIDogcGNyeXB0
CnByaW9yaXR5ICAgICA6IDEyNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNz
ZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5
ZXMKYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDY0Cmdl
bml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTUxMiks
Y3RyKGRlcykpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGE1MTItYXZ4MiksY3RyKGRl
cy1nZW5lcmljKSkKbW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAxMTcwCnJl
ZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5
cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQppdnNp
emUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFt
ZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4NCksY3RyKGRlcykpCmRyaXZlciAgICAgICA6
IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMzg0LWF2eDIpLGN0cihkZXMtZ2VuZXJpYykpKQptb2R1
bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMTI3MApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFk
CmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgKbWF4
YXV0aHNpemUgIDogNDgKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRo
ZW5jKGhtYWMoc2hhMzg0KSxjdHIoZGVzKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNo
YTM4NC1hdngyKSxjdHIoZGVzLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9y
aXR5ICAgICA6IDExNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50
ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9j
a3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogNDgKZ2VuaXYgICAg
ICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMjU2KSxjdHIoZGVz
KSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhzaGEyNTYtZ2VuZXJpYyksY3Ry
KGRlcy1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMjAw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDEK
aXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAzMgpnZW5pdiAgICAgICAgOiA8bm9uZT4K
Cm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGN0cihkZXMpKQpkcml2ZXIgICAg
ICAgOiBhdXRoZW5jKGhtYWMoc2hhMjU2LWdlbmVyaWMpLGN0cihkZXMtZ2VuZXJpYykpCm1vZHVs
ZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMTEwMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFk
CmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXplICAgICAgIDogOAptYXhh
dXRoc2l6ZSAgOiAzMgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhl
bmMoaG1hYyhzaGExKSxjdHIoZGVzKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1h
YyhzaGExLWdlbmVyaWMpLGN0cihkZXMtZ2VuZXJpYykpKQptb2R1bGUgICAgICAgOiBwY3J5cHQK
cHJpb3JpdHkgICAgIDogMTIwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3Nl
ZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHll
cwpibG9ja3NpemUgICAgOiAxCml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMjAKZ2Vu
aXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMSksY3Ry
KGRlcykpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGExLWdlbmVyaWMpLGN0cihkZXMt
Z2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMTEwMApyZWZj
bnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKaXZzaXpl
ICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUg
ICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGN0cihkZXMpKQpkcml2ZXIgICAgICAgOiBwY3J5
cHQoYXV0aGVuYyhobWFjKG1kNS1nZW5lcmljKSxjdHIoZGVzLWdlbmVyaWMpKSkKbW9kdWxlICAg
ICAgIDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDExMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVz
dCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3lu
YyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhz
aXplICA6IDE2Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyho
bWFjKG1kNSksY3RyKGRlcykpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUtZ2VuZXJp
YyksY3RyKGRlcy1nZW5lcmljKSkKbW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAg
OiAxMDAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAg
ICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAg
IDogMQppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDE2Cmdlbml2ICAgICAgICA6IDxu
b25lPgoKbmFtZSAgICAgICAgIDogY3RyKGRlcykKZHJpdmVyICAgICAgIDogY3RyKGRlcy1nZW5l
cmljKQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAg
ICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAg
ICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKbWluIGtleXNp
emUgIDogOAptYXgga2V5c2l6ZSAgOiA4Cml2c2l6ZSAgICAgICA6IDgKY2h1bmtzaXplICAgIDog
OAp3YWxrc2l6ZSAgICAgOiA4CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxj
YmMoY2FzdDUpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTUxMi1hdngy
KSxjYmMtY2FzdDUtYXZ4KSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDIy
NzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDog
bm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDog
OAppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxub25l
PgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTUxMiksY2JjKGNhc3Q1KSkKZHJpdmVy
ICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTUxMi1hdngyKSxjYmMtY2FzdDUtYXZ4KQptb2R1bGUg
ICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDIxNzAKcmVmY250ICAgICAgIDogMQpzZWxm
dGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAph
c3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogOAppdnNpemUgICAgICAgOiA4Cm1heGF1
dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVu
YyhobWFjKHNoYTM4NCksY2JjKGNhc3Q1KSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMo
aG1hYyhzaGEzODQtYXZ4MiksY2JjLWNhc3Q1LWF2eCkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApw
cmlvcml0eSAgICAgOiAyMjcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2Vk
CmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVz
CmJsb2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiA0OApnZW5p
diAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQpLGNi
YyhjYXN0NSkpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQtYXZ4MiksY2JjLWNh
c3Q1LWF2eCkKbW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAyMTcwCnJlZmNu
dCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUg
ICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDgKaXZzaXpl
ICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUg
ICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGNiYyhjYXN0NSkpCmRyaXZlciAgICAgICA6
IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMjU2LWdlbmVyaWMpLGNiYy1jYXN0NS1hdngpKQptb2R1
bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMjIwMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFk
CmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4
YXV0aHNpemUgIDogMzIKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRo
ZW5jKGhtYWMoc2hhMjU2KSxjYmMoY2FzdDUpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMo
c2hhMjU2LWdlbmVyaWMpLGNiYy1jYXN0NS1hdngpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJp
b3JpdHkgICAgIDogMjEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpi
bG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMzIKZ2VuaXYg
ICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMSksY2JjKGNh
c3Q1KSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhzaGExLWdlbmVyaWMpLGNi
Yy1jYXN0NS1hdngpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMjIwMApy
ZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0
eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiA4Cml2
c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMjAKZ2VuaXYgICAgICAgIDogPG5vbmU+Cgpu
YW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMSksY2JjKGNhc3Q1KSkKZHJpdmVyICAgICAg
IDogYXV0aGVuYyhobWFjKHNoYTEtZ2VuZXJpYyksY2JjLWNhc3Q1LWF2eCkKbW9kdWxlICAgICAg
IDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAyMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3Qg
ICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMg
ICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6
ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1h
YyhtZDUpLGNiYyhjYXN0NSkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMobWQ1
LWdlbmVyaWMpLGNiYy1jYXN0NS1hdngpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkg
ICAgIDogMjEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5h
bCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3Np
emUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAg
IDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1KSxjYmMoY2FzdDUpKQpk
cml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1LWdlbmVyaWMpLGNiYy1jYXN0NS1hdngpCm1v
ZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMjAwMApyZWZjbnQgICAgICAgOiAx
CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBh
ZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgK
bWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBh
dXRoZW5jKGhtYWMoc2hhNTEyKSxjYmMoY2FtZWxsaWEpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQo
YXV0aGVuYyhobWFjKHNoYTUxMi1hdngyKSxjYmMtY2FtZWxsaWEtYXNtKSkKbW9kdWxlICAgICAg
IDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDMyNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAg
ICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMTYKaXZzaXplICAgICAgIDogMTYKbWF4YXV0aHNp
emUgIDogNjQKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGht
YWMoc2hhNTEyKSxjYmMoY2FtZWxsaWEpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hh
NTEyLWF2eDIpLGNiYy1jYW1lbGxpYS1hc20pCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3Jp
dHkgICAgIDogMzE3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRl
cm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nr
c2l6ZSAgICA6IDE2Cml2c2l6ZSAgICAgICA6IDE2Cm1heGF1dGhzaXplICA6IDY0Cmdlbml2ICAg
ICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4NCksY2JjKGNh
bWVsbGlhKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhzaGEzODQtYXZ4Miks
Y2JjLWNhbWVsbGlhLWFzbSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAz
MjcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6
IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6
IDE2Cml2c2l6ZSAgICAgICA6IDE2Cm1heGF1dGhzaXplICA6IDQ4Cmdlbml2ICAgICAgICA6IDxu
b25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4NCksY2JjKGNhbWVsbGlhKSkK
ZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4NC1hdngyKSxjYmMtY2FtZWxsaWEtYXNt
KQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDMxNzAKcmVmY250ICAgICAg
IDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgppdnNpemUgICAgICAg
OiAxNgptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAg
ICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGNiYyhjYW1lbGxpYSkpCmRyaXZlciAgICAgICA6IHBj
cnlwdChhdXRoZW5jKGhtYWMoc2hhMjU2LWdlbmVyaWMpLGNiYy1jYW1lbGxpYS1hc20pKQptb2R1
bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMzIwMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFk
CmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxNgppdnNpemUgICAgICAgOiAxNgpt
YXhhdXRoc2l6ZSAgOiAzMgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1
dGhlbmMoaG1hYyhzaGEyNTYpLGNiYyhjYW1lbGxpYSkpCmRyaXZlciAgICAgICA6IGF1dGhlbmMo
aG1hYyhzaGEyNTYtZ2VuZXJpYyksY2JjLWNhbWVsbGlhLWFzbSkKbW9kdWxlICAgICAgIDogYXV0
aGVuYwpwcmlvcml0eSAgICAgOiAzMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAg
IDogbm8KYmxvY2tzaXplICAgIDogMTYKaXZzaXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDog
MzIKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hh
MSksY2JjKGNhbWVsbGlhKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhzaGEx
LWdlbmVyaWMpLGNiYy1jYW1lbGxpYS1hc20pKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3Jp
dHkgICAgIDogMzIwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRl
cm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9j
a3NpemUgICAgOiAxNgppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAg
ICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGExKSxjYmMoY2Ft
ZWxsaWEpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMS1nZW5lcmljKSxjYmMtY2Ft
ZWxsaWEtYXNtKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDMxMDAKcmVm
Y250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgppdnNp
emUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5h
bWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGNiYyhjYW1lbGxpYSkpCmRyaXZlciAgICAg
ICA6IHBjcnlwdChhdXRoZW5jKGhtYWMobWQ1LWdlbmVyaWMpLGNiYy1jYW1lbGxpYS1hc20pKQpt
b2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMzEwMApyZWZjbnQgICAgICAgOiAx
CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBh
ZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxNgppdnNpemUgICAgICAgOiAx
NgptYXhhdXRoc2l6ZSAgOiAxNgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6
IGF1dGhlbmMoaG1hYyhtZDUpLGNiYyhjYW1lbGxpYSkpCmRyaXZlciAgICAgICA6IGF1dGhlbmMo
aG1hYyhtZDUtZ2VuZXJpYyksY2JjLWNhbWVsbGlhLWFzbSkKbW9kdWxlICAgICAgIDogYXV0aGVu
Ywpwcmlvcml0eSAgICAgOiAzMDAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFz
c2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDog
bm8KYmxvY2tzaXplICAgIDogMTYKaXZzaXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDogMTYK
Z2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEy
KSxjYmMoYmxvd2Zpc2gpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTUx
Mi1hdngyKSxjYmMtYmxvd2Zpc2gtYXNtKSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5
ICAgICA6IDMyNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tz
aXplICAgIDogOAppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDY0Cmdlbml2ICAgICAg
ICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTUxMiksY2JjKGJsb3dm
aXNoKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTUxMi1hdngyKSxjYmMtYmxvd2Zp
c2gtYXNtKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDMxNzAKcmVmY250
ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAg
ICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAg
ICAgICA6IDgKbWF4YXV0aHNpemUgIDogNjQKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAg
ICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMzg0KSxjYmMoYmxvd2Zpc2gpKQpkcml2ZXIgICAgICAg
OiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTM4NC1hdngyKSxjYmMtYmxvd2Zpc2gtYXNtKSkKbW9k
dWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDMyNzAKcmVmY250ICAgICAgIDogMQpz
ZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVh
ZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogOAppdnNpemUgICAgICAgOiA4Cm1h
eGF1dGhzaXplICA6IDQ4Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0
aGVuYyhobWFjKHNoYTM4NCksY2JjKGJsb3dmaXNoKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyho
bWFjKHNoYTM4NC1hdngyKSxjYmMtYmxvd2Zpc2gtYXNtKQptb2R1bGUgICAgICAgOiBhdXRoZW5j
CnByaW9yaXR5ICAgICA6IDMxNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNz
ZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBu
bwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogNDgKZ2Vu
aXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMjU2KSxj
YmMoYmxvd2Zpc2gpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTI1Ni1n
ZW5lcmljKSxjYmMtYmxvd2Zpc2gtYXNtKSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5
ICAgICA6IDMyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tz
aXplICAgIDogOAppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDMyCmdlbml2ICAgICAg
ICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTI1NiksY2JjKGJsb3dm
aXNoKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTI1Ni1nZW5lcmljKSxjYmMtYmxv
d2Zpc2gtYXNtKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDMxMDAKcmVm
Y250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiA4Cml2c2l6
ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMzIKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1l
ICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMSksY2JjKGJsb3dmaXNoKSkKZHJpdmVyICAgICAg
IDogcGNyeXB0KGF1dGhlbmMoaG1hYyhzaGExLWdlbmVyaWMpLGNiYy1ibG93ZmlzaC1hc20pKQpt
b2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMzIwMApyZWZjbnQgICAgICAgOiAx
CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBh
ZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgK
bWF4YXV0aHNpemUgIDogMjAKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBh
dXRoZW5jKGhtYWMoc2hhMSksY2JjKGJsb3dmaXNoKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyho
bWFjKHNoYTEtZ2VuZXJpYyksY2JjLWJsb3dmaXNoLWFzbSkKbW9kdWxlICAgICAgIDogYXV0aGVu
Ywpwcmlvcml0eSAgICAgOiAzMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFz
c2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDog
bm8KYmxvY2tzaXplICAgIDogOAppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDIwCmdl
bml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKG1kNSksY2Jj
KGJsb3dmaXNoKSkKZHJpdmVyICAgICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhtZDUtZ2VuZXJp
YyksY2JjLWJsb3dmaXNoLWFzbSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAg
OiAzMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAg
ICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAg
ICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAxNgpnZW5pdiAgICAgICAgOiA8
bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGNiYyhibG93ZmlzaCkpCmRy
aXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUtZ2VuZXJpYyksY2JjLWJsb3dmaXNoLWFzbSkK
bW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAzMDAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogOAppdnNpemUgICAgICAgOiA4
Cm1heGF1dGhzaXplICA6IDE2Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDog
YXV0aGVuYyhobWFjKHNoYTUxMiksY2JjKGFlcykpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRo
ZW5jKGhtYWMoc2hhNTEyLWF2eDIpLGNiYyhhZXMtZ2VuZXJpYykpKQptb2R1bGUgICAgICAgOiBw
Y3J5cHQKcHJpb3JpdHkgICAgIDogMTI3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAg
ICA6IHllcwpibG9ja3NpemUgICAgOiAxNgppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAg
OiA2NApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhz
aGE1MTIpLGNiYyhhZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyLWF2eDIp
LGNiYyhhZXMtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDog
MTE3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAg
OiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6
IDE2Cml2c2l6ZSAgICAgICA6IDE2Cm1heGF1dGhzaXplICA6IDY0Cmdlbml2ICAgICAgICA6IDxu
b25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTM4NCksY2JjKGFlcykpCmRyaXZl
ciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMzg0LWF2eDIpLGNiYyhhZXMtZ2VuZXJp
YykpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDogMTI3MApyZWZjbnQgICAg
ICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAg
ICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxNgppdnNpemUgICAg
ICAgOiAxNgptYXhhdXRoc2l6ZSAgOiA0OApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAg
ICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQpLGNiYyhhZXMpKQpkcml2ZXIgICAgICAgOiBhdXRo
ZW5jKGhtYWMoc2hhMzg0LWF2eDIpLGNiYyhhZXMtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1
dGhlbmMKcHJpb3JpdHkgICAgIDogMTE3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAg
ICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDE2Cml2c2l6ZSAgICAgICA6IDE2Cm1heGF1dGhzaXplICA6
IDQ4Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNo
YTI1NiksY2JjKGFlcykpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMjU2
LWdlbmVyaWMpLGNiYyhhZXMtZ2VuZXJpYykpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3Jp
dHkgICAgIDogMTIwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRl
cm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9j
a3NpemUgICAgOiAxNgppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiAzMgpnZW5pdiAg
ICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEyNTYpLGNiYyhh
ZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMjU2LWdlbmVyaWMpLGNiYyhhZXMt
Z2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMTEwMApyZWZj
bnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDE2Cml2c2l6
ZSAgICAgICA6IDE2Cm1heGF1dGhzaXplICA6IDMyCmdlbml2ICAgICAgICA6IDxub25lPgoKbmFt
ZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTEpLGNiYyhhZXMpKQpkcml2ZXIgICAgICAgOiBw
Y3J5cHQoYXV0aGVuYyhobWFjKHNoYTEtZ2VuZXJpYyksY2JjKGFlcy1nZW5lcmljKSkpCm1vZHVs
ZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMjAwCnJlZmNudCAgICAgICA6IDEKc2Vs
ZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQK
YXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDE2Cml2c2l6ZSAgICAgICA6IDE2Cm1h
eGF1dGhzaXplICA6IDIwCmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0
aGVuYyhobWFjKHNoYTEpLGNiYyhhZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hh
MS1nZW5lcmljKSxjYmMoYWVzLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9y
aXR5ICAgICA6IDExMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50
ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9j
a3NpemUgICAgOiAxNgppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAg
ICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGNiYyhhZXMp
KQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKG1kNS1nZW5lcmljKSxjYmMoYWVz
LWdlbmVyaWMpKSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDExMDAKcmVm
Y250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMTYKaXZz
aXplICAgICAgIDogMTYKbWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAgIDogPG5vbmU+Cgpu
YW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1KSxjYmMoYWVzKSkKZHJpdmVyICAgICAgIDog
YXV0aGVuYyhobWFjKG1kNS1nZW5lcmljKSxjYmMoYWVzLWdlbmVyaWMpKQptb2R1bGUgICAgICAg
OiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDEwMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAg
ICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgppdnNpemUgICAgICAgOiAxNgptYXhhdXRoc2l6
ZSAgOiAxNgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1h
YyhzaGE1MTIpLGNiYyhkZXMzX2VkZSkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGht
YWMoc2hhNTEyLWF2eDIpLGNiYyhkZXMzX2VkZS1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6IHBj
cnlwdApwcmlvcml0eSAgICAgOiAxMjcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAg
IDogeWVzCmJsb2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiA2
NApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGE1
MTIpLGNiYyhkZXMzX2VkZSkpCmRyaXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGE1MTItYXZ4
MiksY2JjKGRlczNfZWRlLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5
ICAgICA6IDExNzAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3Np
emUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogNjQKZ2VuaXYgICAgICAg
IDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMzg0KSxjYmMoZGVzM19l
ZGUpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTM4NC1hdngyKSxjYmMo
ZGVzM19lZGUtZ2VuZXJpYykpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkgICAgIDog
MTI3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAg
OiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAg
OiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogNDgKZ2VuaXYgICAgICAgIDogPG5v
bmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMzg0KSxjYmMoZGVzM19lZGUpKQpk
cml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMzg0LWF2eDIpLGNiYyhkZXMzX2VkZS1nZW5l
cmljKSkKbW9kdWxlICAgICAgIDogYXV0aGVuYwpwcmlvcml0eSAgICAgOiAxMTcwCnJlZmNudCAg
ICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAg
ICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogOAppdnNpemUgICAg
ICAgOiA4Cm1heGF1dGhzaXplICA6IDQ4Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAg
ICAgIDogYXV0aGVuYyhobWFjKHNoYTI1NiksY2JjKGRlczNfZWRlKSkKZHJpdmVyICAgICAgIDog
cGNyeXB0KGF1dGhlbmMoaG1hYyhzaGEyNTYtZ2VuZXJpYyksY2JjKGRlczNfZWRlLWdlbmVyaWMp
KSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDEyMDAKcmVmY250ICAgICAg
IDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogOAppdnNpemUgICAgICAg
OiA4Cm1heGF1dGhzaXplICA6IDMyCmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAg
IDogYXV0aGVuYyhobWFjKHNoYTI1NiksY2JjKGRlczNfZWRlKSkKZHJpdmVyICAgICAgIDogYXV0
aGVuYyhobWFjKHNoYTI1Ni1nZW5lcmljKSxjYmMoZGVzM19lZGUtZ2VuZXJpYykpCm1vZHVsZSAg
ICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAgIDogMTEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFz
eW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRo
c2l6ZSAgOiAzMgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMo
aG1hYyhzaGExKSxjYmMoZGVzM19lZGUpKQpkcml2ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyho
bWFjKHNoYTEtZ2VuZXJpYyksY2JjKGRlczNfZWRlLWdlbmVyaWMpKSkKbW9kdWxlICAgICAgIDog
cGNyeXB0CnByaW9yaXR5ICAgICA6IDEyMDAKcmVmY250ICAgICAgIDogNDEwCnNlbGZ0ZXN0ICAg
ICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAg
ICAgICA6IHllcwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUg
IDogMjAKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMo
c2hhMSksY2JjKGRlczNfZWRlKSkKZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTEtZ2Vu
ZXJpYyksY2JjKGRlczNfZWRlLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9y
aXR5ICAgICA6IDExMDAKcmVmY250ICAgICAgIDogNDEwCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJs
b2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAyMApnZW5pdiAg
ICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGNiYyhkZXMz
X2VkZSkpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMobWQ1LWdlbmVyaWMpLGNi
YyhkZXMzX2VkZS1nZW5lcmljKSkpCm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAg
OiAxMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAg
ICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAg
ICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAxNgpnZW5pdiAgICAgICAgOiA8
bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUpLGNiYyhkZXMzX2VkZSkpCmRy
aXZlciAgICAgICA6IGF1dGhlbmMoaG1hYyhtZDUtZ2VuZXJpYyksY2JjKGRlczNfZWRlLWdlbmVy
aWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDEwMDAKcmVmY250ICAg
ICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAg
ICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAg
ICA6IDgKbWF4YXV0aHNpemUgIDogMTYKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAg
ICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyKSxjYmMoZGVzKSkKZHJpdmVyICAgICAgIDogcGNyeXB0
KGF1dGhlbmMoaG1hYyhzaGE1MTItYXZ4MiksY2JjKGRlcy1nZW5lcmljKSkpCm1vZHVsZSAgICAg
ICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMjcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3Qg
ICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMg
ICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6
ZSAgOiA2NApnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1h
YyhzaGE1MTIpLGNiYyhkZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhNTEyLWF2
eDIpLGNiYyhkZXMtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJpb3JpdHkgICAg
IDogMTE3MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAg
ICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAg
ICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiA2NApnZW5pdiAgICAgICAgOiA8
bm9uZT4KCm5hbWUgICAgICAgICA6IGF1dGhlbmMoaG1hYyhzaGEzODQpLGNiYyhkZXMpKQpkcml2
ZXIgICAgICAgOiBwY3J5cHQoYXV0aGVuYyhobWFjKHNoYTM4NC1hdngyKSxjYmMoZGVzLWdlbmVy
aWMpKSkKbW9kdWxlICAgICAgIDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDEyNzAKcmVmY250ICAg
ICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAg
ICAgIDogYWVhZAphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogOAppdnNpemUgICAg
ICAgOiA4Cm1heGF1dGhzaXplICA6IDQ4Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAg
ICAgIDogYXV0aGVuYyhobWFjKHNoYTM4NCksY2JjKGRlcykpCmRyaXZlciAgICAgICA6IGF1dGhl
bmMoaG1hYyhzaGEzODQtYXZ4MiksY2JjKGRlcy1nZW5lcmljKSkKbW9kdWxlICAgICAgIDogYXV0
aGVuYwpwcmlvcml0eSAgICAgOiAxMTcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFlYWQKYXN5bmMgICAgICAg
IDogbm8KYmxvY2tzaXplICAgIDogOAppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXplICA6IDQ4
Cmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTI1
NiksY2JjKGRlcykpCmRyaXZlciAgICAgICA6IHBjcnlwdChhdXRoZW5jKGhtYWMoc2hhMjU2LWdl
bmVyaWMpLGNiYyhkZXMtZ2VuZXJpYykpKQptb2R1bGUgICAgICAgOiBwY3J5cHQKcHJpb3JpdHkg
ICAgIDogMTIwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5h
bCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IHllcwpibG9ja3Np
emUgICAgOiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMzIKZ2VuaXYgICAgICAg
IDogPG5vbmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMjU2KSxjYmMoZGVzKSkK
ZHJpdmVyICAgICAgIDogYXV0aGVuYyhobWFjKHNoYTI1Ni1nZW5lcmljKSxjYmMoZGVzLWdlbmVy
aWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6IDExMDAKcmVmY250ICAg
ICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAg
ICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiA4Cml2c2l6ZSAgICAg
ICA6IDgKbWF4YXV0aHNpemUgIDogMzIKZ2VuaXYgICAgICAgIDogPG5vbmU+CgpuYW1lICAgICAg
ICAgOiBhdXRoZW5jKGhtYWMoc2hhMSksY2JjKGRlcykpCmRyaXZlciAgICAgICA6IHBjcnlwdChh
dXRoZW5jKGhtYWMoc2hhMS1nZW5lcmljKSxjYmMoZGVzLWdlbmVyaWMpKSkKbW9kdWxlICAgICAg
IDogcGNyeXB0CnByaW9yaXR5ICAgICA6IDEyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAg
ICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogOAppdnNpemUgICAgICAgOiA4Cm1heGF1dGhzaXpl
ICA6IDIwCmdlbml2ICAgICAgICA6IDxub25lPgoKbmFtZSAgICAgICAgIDogYXV0aGVuYyhobWFj
KHNoYTEpLGNiYyhkZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMoc2hhMS1nZW5lcmlj
KSxjYmMoZGVzLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBhdXRoZW5jCnByaW9yaXR5ICAgICA6
IDExMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAg
IDogbm8KdHlwZSAgICAgICAgIDogYWVhZAphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAg
OiA4Cml2c2l6ZSAgICAgICA6IDgKbWF4YXV0aHNpemUgIDogMjAKZ2VuaXYgICAgICAgIDogPG5v
bmU+CgpuYW1lICAgICAgICAgOiBhdXRoZW5jKGhtYWMobWQ1KSxjYmMoZGVzKSkKZHJpdmVyICAg
ICAgIDogcGNyeXB0KGF1dGhlbmMoaG1hYyhtZDUtZ2VuZXJpYyksY2JjKGRlcy1nZW5lcmljKSkp
Cm1vZHVsZSAgICAgICA6IHBjcnlwdApwcmlvcml0eSAgICAgOiAxMTAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGFlYWQKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDog
OAptYXhhdXRoc2l6ZSAgOiAxNgpnZW5pdiAgICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6
IGF1dGhlbmMoaG1hYyhtZDUpLGNiYyhkZXMpKQpkcml2ZXIgICAgICAgOiBhdXRoZW5jKGhtYWMo
bWQ1LWdlbmVyaWMpLGNiYyhkZXMtZ2VuZXJpYykpCm1vZHVsZSAgICAgICA6IGF1dGhlbmMKcHJp
b3JpdHkgICAgIDogMTAwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBhZWFkCmFzeW5jICAgICAgICA6IG5vCmJs
b2Nrc2l6ZSAgICA6IDgKaXZzaXplICAgICAgIDogOAptYXhhdXRoc2l6ZSAgOiAxNgpnZW5pdiAg
ICAgICAgOiA8bm9uZT4KCm5hbWUgICAgICAgICA6IGNiYyh0d29maXNoKQpkcml2ZXIgICAgICAg
OiBjYmModHdvZmlzaC1hc20pCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAy
MDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDog
bm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAg
IDogMTYKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDog
MTYKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5hbWUgICAgICAgICA6IHR3
b2Zpc2gKZHJpdmVyICAgICAgIDogdHdvZmlzaC1nZW5lcmljCm1vZHVsZSAgICAgICA6IHR3b2Zp
c2hfZ2VuZXJpYwpwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogY2lwaGVyCmJsb2Nr
c2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDE2Cm1heCBrZXlzaXplICA6IDMyCgpuYW1lICAg
ICAgICAgOiBfX2NiYyh0d29maXNoKQpkcml2ZXIgICAgICAgOiBjcnlwdGQoX19jYmMtdHdvZmlz
aC1hdngpCm1vZHVsZSAgICAgICA6IGNyeXB0ZApwcmlvcml0eSAgICAgOiA0NTAKcmVmY250ICAg
ICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogeWVzCnR5cGUgICAg
ICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxNgptaW4g
a2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3Np
emUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDogY2JjKHR3b2Zpc2gp
CmRyaXZlciAgICAgICA6IGNiYy10d29maXNoLWF2eAptb2R1bGUgICAgICAgOiB0d29maXNoX2F2
eF94ODZfNjQKcHJpb3JpdHkgICAgIDogNDAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAg
IDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5j
ICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5
c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAg
ICAgOiAxNgoKbmFtZSAgICAgICAgIDogX19lY2IodHdvZmlzaCkKZHJpdmVyICAgICAgIDogY3J5
cHRkKF9fZWNiLXR3b2Zpc2gtYXZ4KQptb2R1bGUgICAgICAgOiBjcnlwdGQKcHJpb3JpdHkgICAg
IDogNDUwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAg
ICA6IHllcwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tz
aXplICAgIDogMTYKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAg
ICAgIDogMApjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAg
IDogZWNiKHR3b2Zpc2gpCmRyaXZlciAgICAgICA6IGVjYi10d29maXNoLWF2eAptb2R1bGUgICAg
ICAgOiB0d29maXNoX2F2eF94ODZfNjQKcHJpb3JpdHkgICAgIDogNDAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IHllcwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6
ZSAgOiAxNgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAwCmNodW5rc2l6ZSAgICA6
IDE2CndhbGtzaXplICAgICA6IDE2CgpuYW1lICAgICAgICAgOiBfX2NiYyh0d29maXNoKQpkcml2
ZXIgICAgICAgOiBfX2NiYy10d29maXNoLWF2eAptb2R1bGUgICAgICAgOiB0d29maXNoX2F2eF94
ODZfNjQKcHJpb3JpdHkgICAgIDogNDAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IHllcwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAg
ICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6
ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAgICAg
OiAxNgoKbmFtZSAgICAgICAgIDogX19lY2IodHdvZmlzaCkKZHJpdmVyICAgICAgIDogX19lY2It
dHdvZmlzaC1hdngKbW9kdWxlICAgICAgIDogdHdvZmlzaF9hdnhfeDg2XzY0CnByaW9yaXR5ICAg
ICA6IDQwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAg
ICAgOiB5ZXMKdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tz
aXplICAgIDogMTYKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAg
ICAgIDogMApjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAg
IDogY2JjKHR3b2Zpc2gpCmRyaXZlciAgICAgICA6IGNiYy10d29maXNoLTN3YXkKbW9kdWxlICAg
ICAgIDogdHdvZmlzaF94ODZfNjRfM3dheQpwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAg
IDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNp
emUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDogMTYKY2h1bmtzaXplICAg
IDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5hbWUgICAgICAgICA6IGVjYih0d29maXNoKQpkcml2
ZXIgICAgICAgOiBlY2ItdHdvZmlzaC0zd2F5Cm1vZHVsZSAgICAgICA6IHR3b2Zpc2hfeDg2XzY0
XzN3YXkKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAg
ICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDE2Cm1heCBrZXlzaXpl
ICA6IDMyCml2c2l6ZSAgICAgICA6IDAKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDog
MTYKCm5hbWUgICAgICAgICA6IHR3b2Zpc2gKZHJpdmVyICAgICAgIDogdHdvZmlzaC1hc20KbW9k
dWxlICAgICAgIDogdHdvZmlzaF94ODZfNjQKcHJpb3JpdHkgICAgIDogMjAwCnJlZmNudCAgICAg
ICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAg
ICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6
ZSAgOiAzMgoKbmFtZSAgICAgICAgIDogX19jYmMoc2VycGVudCkKZHJpdmVyICAgICAgIDogY3J5
cHRkKF9fY2JjLXNlcnBlbnQtc3NlMikKbW9kdWxlICAgICAgIDogY3J5cHRkCnByaW9yaXR5ICAg
ICA6IDQ1MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAg
ICAgOiB5ZXMKdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nr
c2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDAKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAg
ICAgIDogMTYKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5hbWUgICAgICAg
ICA6IGNiYyhzZXJwZW50KQpkcml2ZXIgICAgICAgOiBjYmMoc2VycGVudC1nZW5lcmljKQptb2R1
bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2Vs
ZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lw
aGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDAK
bWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDogMTYKY2h1bmtzaXplICAgIDogMTYKd2Fs
a3NpemUgICAgIDogMTYKCm5hbWUgICAgICAgICA6IF9fY2JjKHNlcnBlbnQpCmRyaXZlciAgICAg
ICA6IGNyeXB0ZChfX2NiYy1zZXJwZW50LWF2eCkKbW9kdWxlICAgICAgIDogY3J5cHRkCnByaW9y
aXR5ICAgICA6IDU1MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRl
cm5hbCAgICAgOiB5ZXMKdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogeWVz
CmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDAKbWF4IGtleXNpemUgIDogMzIKaXZz
aXplICAgICAgIDogMTYKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5hbWUg
ICAgICAgICA6IGNiYyhzZXJwZW50KQpkcml2ZXIgICAgICAgOiBjYmMtc2VycGVudC1hdngKbW9k
dWxlICAgICAgIDogc2VycGVudF9hdnhfeDg2XzY0CnByaW9yaXR5ICAgICA6IDUwMApyZWZjbnQg
ICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMTYKbWlu
IGtleXNpemUgIDogMAptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3Np
emUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDogX19lY2Ioc2VycGVu
dCkKZHJpdmVyICAgICAgIDogY3J5cHRkKF9fZWNiLXNlcnBlbnQtYXZ4KQptb2R1bGUgICAgICAg
OiBjcnlwdGQKcHJpb3JpdHkgICAgIDogNTUwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAg
IDogcGFzc2VkCmludGVybmFsICAgICA6IHllcwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3lu
YyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNpemUgIDogMAptYXgga2V5
c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAwCmNodW5rc2l6ZSAgICA6IDE2CndhbGtzaXplICAg
ICA6IDE2CgpuYW1lICAgICAgICAgOiBlY2Ioc2VycGVudCkKZHJpdmVyICAgICAgIDogZWNiLXNl
cnBlbnQtYXZ4Cm1vZHVsZSAgICAgICA6IHNlcnBlbnRfYXZ4X3g4Nl82NApwcmlvcml0eSAgICAg
OiA1MDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAg
IDogbm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6
ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDAKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAg
IDogMApjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDog
X19jYmMoc2VycGVudCkKZHJpdmVyICAgICAgIDogX19jYmMtc2VycGVudC1hdngKbW9kdWxlICAg
ICAgIDogc2VycGVudF9hdnhfeDg2XzY0CnByaW9yaXR5ICAgICA6IDUwMApyZWZjbnQgICAgICAg
OiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiB5ZXMKdHlwZSAgICAgICAg
IDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNp
emUgIDogMAptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3NpemUgICAg
OiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDogX19lY2Ioc2VycGVudCkKZHJp
dmVyICAgICAgIDogX19lY2Itc2VycGVudC1hdngKbW9kdWxlICAgICAgIDogc2VycGVudF9hdnhf
eDg2XzY0CnByaW9yaXR5ICAgICA6IDUwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiB5ZXMKdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMg
ICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNpemUgIDogMAptYXgga2V5c2l6
ZSAgOiAzMgppdnNpemUgICAgICAgOiAwCmNodW5rc2l6ZSAgICA6IDE2CndhbGtzaXplICAgICA6
IDE2CgpuYW1lICAgICAgICAgOiBjYmMoc2VycGVudCkKZHJpdmVyICAgICAgIDogY2JjLXNlcnBl
bnQtc3NlMgptb2R1bGUgICAgICAgOiBzZXJwZW50X3NzZTJfeDg2XzY0CnByaW9yaXR5ICAgICA6
IDQwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAg
OiBubwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXpl
ICAgIDogMTYKbWluIGtleXNpemUgIDogMAptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAg
OiAxNgpjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDog
ZWNiKHNlcnBlbnQpCmRyaXZlciAgICAgICA6IGVjYi1zZXJwZW50LXNzZTIKbW9kdWxlICAgICAg
IDogc2VycGVudF9zc2UyX3g4Nl82NApwcmlvcml0eSAgICAgOiA0MDAKcmVmY250ICAgICAgIDog
MQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDog
c2tjaXBoZXIKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXpl
ICA6IDAKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDogMApjaHVua3NpemUgICAgOiAx
Ngp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDogX19jYmMoc2VycGVudCkKZHJpdmVy
ICAgICAgIDogX19jYmMtc2VycGVudC1zc2UyCm1vZHVsZSAgICAgICA6IHNlcnBlbnRfc3NlMl94
ODZfNjQKcHJpb3JpdHkgICAgIDogNDAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IHllcwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAg
ICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAwCm1heCBrZXlzaXpl
ICA6IDMyCml2c2l6ZSAgICAgICA6IDE2CmNodW5rc2l6ZSAgICA6IDE2CndhbGtzaXplICAgICA6
IDE2CgpuYW1lICAgICAgICAgOiBfX2VjYihzZXJwZW50KQpkcml2ZXIgICAgICAgOiBfX2VjYi1z
ZXJwZW50LXNzZTIKbW9kdWxlICAgICAgIDogc2VycGVudF9zc2UyX3g4Nl82NApwcmlvcml0eSAg
ICAgOiA0MDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwg
ICAgIDogeWVzCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nr
c2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDAKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAg
ICAgIDogMApjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAg
IDogc2VycGVudApkcml2ZXIgICAgICAgOiBzZXJwZW50LWdlbmVyaWMKbW9kdWxlICAgICAgIDog
c2VycGVudF9nZW5lcmljCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBjaXBoZXIK
YmxvY2tzaXplICAgIDogMTYKbWluIGtleXNpemUgIDogMAptYXgga2V5c2l6ZSAgOiAzMgoKbmFt
ZSAgICAgICAgIDogY2JjKGNhc3Q1KQpkcml2ZXIgICAgICAgOiBjYmMoY2FzdDUtZ2VuZXJpYykK
bW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAx
CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBz
a2NpcGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6
IDUKbWF4IGtleXNpemUgIDogMTYKaXZzaXplICAgICAgIDogOApjaHVua3NpemUgICAgOiA4Cndh
bGtzaXplICAgICA6IDgKCm5hbWUgICAgICAgICA6IF9fY2JjKGNhc3Q1KQpkcml2ZXIgICAgICAg
OiBjcnlwdGQoX19jYmMtY2FzdDUtYXZ4KQptb2R1bGUgICAgICAgOiBjcnlwdGQKcHJpb3JpdHkg
ICAgIDogMjUwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFs
ICAgICA6IHllcwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiB5ZXMKYmxv
Y2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA1Cm1heCBrZXlzaXplICA6IDE2Cml2c2l6ZSAg
ICAgICA6IDgKY2h1bmtzaXplICAgIDogOAp3YWxrc2l6ZSAgICAgOiA4CgpuYW1lICAgICAgICAg
OiBjYmMoY2FzdDUpCmRyaXZlciAgICAgICA6IGNiYy1jYXN0NS1hdngKbW9kdWxlICAgICAgIDog
Y2FzdDVfYXZ4X3g4Nl82NApwcmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxm
dGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2tjaXBo
ZXIKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogNQpt
YXgga2V5c2l6ZSAgOiAxNgppdnNpemUgICAgICAgOiA4CmNodW5rc2l6ZSAgICA6IDgKd2Fsa3Np
emUgICAgIDogOAoKbmFtZSAgICAgICAgIDogX19lY2IoY2FzdDUpCmRyaXZlciAgICAgICA6IGNy
eXB0ZChfX2VjYi1jYXN0NS1hdngpCm1vZHVsZSAgICAgICA6IGNyeXB0ZApwcmlvcml0eSAgICAg
OiAyNTAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAg
IDogeWVzCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IHllcwpibG9ja3Np
emUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDUKbWF4IGtleXNpemUgIDogMTYKaXZzaXplICAgICAg
IDogMApjaHVua3NpemUgICAgOiA4CndhbGtzaXplICAgICA6IDgKCm5hbWUgICAgICAgICA6IGVj
YihjYXN0NSkKZHJpdmVyICAgICAgIDogZWNiLWNhc3Q1LWF2eAptb2R1bGUgICAgICAgOiBjYXN0
NV9hdnhfeDg2XzY0CnByaW9yaXR5ICAgICA6IDIwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0
ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2NpcGhlcgph
c3luYyAgICAgICAgOiB5ZXMKYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA1Cm1heCBr
ZXlzaXplICA6IDE2Cml2c2l6ZSAgICAgICA6IDAKY2h1bmtzaXplICAgIDogOAp3YWxrc2l6ZSAg
ICAgOiA4CgpuYW1lICAgICAgICAgOiBfX2NiYyhjYXN0NSkKZHJpdmVyICAgICAgIDogX19jYmMt
Y2FzdDUtYXZ4Cm1vZHVsZSAgICAgICA6IGNhc3Q1X2F2eF94ODZfNjQKcHJpb3JpdHkgICAgIDog
MjAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6
IHllcwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUg
ICAgOiA4Cm1pbiBrZXlzaXplICA6IDUKbWF4IGtleXNpemUgIDogMTYKaXZzaXplICAgICAgIDog
OApjaHVua3NpemUgICAgOiA4CndhbGtzaXplICAgICA6IDgKCm5hbWUgICAgICAgICA6IF9fZWNi
KGNhc3Q1KQpkcml2ZXIgICAgICAgOiBfX2VjYi1jYXN0NS1hdngKbW9kdWxlICAgICAgIDogY2Fz
dDVfYXZ4X3g4Nl82NApwcmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVz
dCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogeWVzCnR5cGUgICAgICAgICA6IHNrY2lwaGVy
CmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogNQptYXgg
a2V5c2l6ZSAgOiAxNgppdnNpemUgICAgICAgOiAwCmNodW5rc2l6ZSAgICA6IDgKd2Fsa3NpemUg
ICAgIDogOAoKbmFtZSAgICAgICAgIDogY2FzdDUKZHJpdmVyICAgICAgIDogY2FzdDUtZ2VuZXJp
Ywptb2R1bGUgICAgICAgOiBjYXN0NV9nZW5lcmljCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQg
ICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA1Cm1heCBrZXlz
aXplICA6IDE2CgpuYW1lICAgICAgICAgOiByZmMzNjg2KGN0cihjYW1lbGxpYSkpCmRyaXZlciAg
ICAgICA6IHJmYzM2ODYoY3RyKGNhbWVsbGlhLWFzbSkpCm1vZHVsZSAgICAgICA6IGtlcm5lbApw
cmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQK
aW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDog
bm8KYmxvY2tzaXplICAgIDogMQptaW4ga2V5c2l6ZSAgOiAyMAptYXgga2V5c2l6ZSAgOiAzNgpp
dnNpemUgICAgICAgOiA4CmNodW5rc2l6ZSAgICA6IDE2CndhbGtzaXplICAgICA6IDE2CgpuYW1l
ICAgICAgICAgOiBjdHIoY2FtZWxsaWEpCmRyaXZlciAgICAgICA6IGN0cihjYW1lbGxpYS1hc20p
Cm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDog
MQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDog
c2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQptaW4ga2V5c2l6ZSAg
OiAxNgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAxNgpjaHVua3NpemUgICAgOiAx
Ngp3YWxrc2l6ZSAgICAgOiAxNgoKbmFtZSAgICAgICAgIDogcmZjMzY4NihjdHIoYWVzKSkKZHJp
dmVyICAgICAgIDogcmZjMzY4NihjdHIoYWVzLWdlbmVyaWMpKQptb2R1bGUgICAgICAgOiBrZXJu
ZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFz
c2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAg
ICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDEKbWluIGtleXNpemUgIDogMjAKbWF4IGtleXNpemUgIDog
MzYKaXZzaXplICAgICAgIDogOApjaHVua3NpemUgICAgOiAxNgp3YWxrc2l6ZSAgICAgOiAxNgoK
bmFtZSAgICAgICAgIDogY2JjKGRlczNfZWRlKQpkcml2ZXIgICAgICAgOiBjYmMoZGVzM19lZGUt
Z2VuZXJpYykKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQg
ICAgICAgOiA0MTAKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUg
ICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKbWlu
IGtleXNpemUgIDogMjQKbWF4IGtleXNpemUgIDogMjQKaXZzaXplICAgICAgIDogOApjaHVua3Np
emUgICAgOiA4CndhbGtzaXplICAgICA6IDgKCm5hbWUgICAgICAgICA6IGVjYihkZXMpCmRyaXZl
ciAgICAgICA6IGVjYihkZXMtZ2VuZXJpYykKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5
ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5h
bCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiBubwpibG9j
a3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDgKbWF4IGtleXNpemUgIDogOAppdnNpemUgICAg
ICAgOiAwCmNodW5rc2l6ZSAgICA6IDgKd2Fsa3NpemUgICAgIDogOAoKbmFtZSAgICAgICAgIDog
Y2JjKGRlcykKZHJpdmVyICAgICAgIDogY2JjKGRlcy1nZW5lcmljKQptb2R1bGUgICAgICAgOiBr
ZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAg
ICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDgKbWluIGtleXNpemUgIDogOAptYXgga2V5c2l6ZSAg
OiA4Cml2c2l6ZSAgICAgICA6IDgKY2h1bmtzaXplICAgIDogOAp3YWxrc2l6ZSAgICAgOiA4Cgpu
YW1lICAgICAgICAgOiBkZXMzX2VkZQpkcml2ZXIgICAgICAgOiBkZXMzX2VkZS1nZW5lcmljCm1v
ZHVsZSAgICAgICA6IGRlc19nZW5lcmljCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAg
OiA0MTAKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAg
ICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDI0Cm1heCBrZXlzaXpl
ICA6IDI0CgpuYW1lICAgICAgICAgOiBkZXMKZHJpdmVyICAgICAgIDogZGVzLWdlbmVyaWMKbW9k
dWxlICAgICAgIDogZGVzX2dlbmVyaWMKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGNpcGhlcgpibG9ja3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDgKbWF4IGtleXNpemUgIDog
OAoKbmFtZSAgICAgICAgIDogeGNiYyhjYW1lbGxpYSkKZHJpdmVyICAgICAgIDogeGNiYyhjYW1l
bGxpYS1hc20pCm1vZHVsZSAgICAgICA6IHhjYmMKcHJpb3JpdHkgICAgIDogMjAwCnJlZmNudCAg
ICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAg
ICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDE2CmRpZ2VzdHNpemUgICA6IDE2CgpuYW1lICAg
ICAgICAgOiBjYW1lbGxpYQpkcml2ZXIgICAgICAgOiBjYW1lbGxpYS1nZW5lcmljCm1vZHVsZSAg
ICAgICA6IGNhbWVsbGlhX2dlbmVyaWMKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGNpcGhlcgpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6ZSAg
OiAzMgoKbmFtZSAgICAgICAgIDogY2JjKGNhbWVsbGlhKQpkcml2ZXIgICAgICAgOiBjYmMtY2Ft
ZWxsaWEtYXNtCm1vZHVsZSAgICAgICA6IGNhbWVsbGlhX3g4Nl82NApwcmlvcml0eSAgICAgOiAz
MDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDog
bm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAg
IDogMTYKbWluIGtleXNpemUgIDogMTYKbWF4IGtleXNpemUgIDogMzIKaXZzaXplICAgICAgIDog
MTYKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUgICAgIDogMTYKCm5hbWUgICAgICAgICA6IGVj
YihjYW1lbGxpYSkKZHJpdmVyICAgICAgIDogZWNiLWNhbWVsbGlhLWFzbQptb2R1bGUgICAgICAg
OiBjYW1lbGxpYV94ODZfNjQKcHJpb3JpdHkgICAgIDogMzAwCnJlZmNudCAgICAgICA6IDEKc2Vs
ZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNrY2lw
aGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBrZXlzaXplICA6IDE2
Cm1heCBrZXlzaXplICA6IDMyCml2c2l6ZSAgICAgICA6IDAKY2h1bmtzaXplICAgIDogMTYKd2Fs
a3NpemUgICAgIDogMTYKCm5hbWUgICAgICAgICA6IGNhbWVsbGlhCmRyaXZlciAgICAgICA6IGNh
bWVsbGlhLWFzbQptb2R1bGUgICAgICAgOiBjYW1lbGxpYV94ODZfNjQKcHJpb3JpdHkgICAgIDog
MjAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6
IG5vCnR5cGUgICAgICAgICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAg
OiAxNgptYXgga2V5c2l6ZSAgOiAzMgoKbmFtZSAgICAgICAgIDogeGNiYyhhZXMpCmRyaXZlciAg
ICAgICA6IHhjYmMoYWVzLWdlbmVyaWMpCm1vZHVsZSAgICAgICA6IHhjYmMKcHJpb3JpdHkgICAg
IDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAg
ICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDE2CmRpZ2VzdHNpemUg
ICA6IDE2CgpuYW1lICAgICAgICAgOiBobWFjKHNoYTUxMikKZHJpdmVyICAgICAgIDogaG1hYyhz
aGE1MTItYXZ4MikKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDE3MApyZWZj
bnQgICAgICAgOiAyCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAgOiAxMjgKZGlnZXN0c2l6ZSAgIDogNjQKCm5h
bWUgICAgICAgICA6IGhtYWMoc2hhMzg0KQpkcml2ZXIgICAgICAgOiBobWFjKHNoYTM4NC1hdngy
KQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTcwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDEyOApkaWdlc3RzaXplICAgOiA0OAoKbmFtZSAgICAgICAg
IDogaG1hYyhtZDUpCmRyaXZlciAgICAgICA6IGhtYWMobWQ1LWdlbmVyaWMpCm1vZHVsZSAgICAg
ICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAg
IDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6
ZSAgICA6IDY0CmRpZ2VzdHNpemUgICA6IDE2CgpuYW1lICAgICAgICAgOiBobWFjKHNoYTEpCmRy
aXZlciAgICAgICA6IGhtYWMoc2hhMS1nZW5lcmljKQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJp
b3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6IDgxOQpzZWxmdGVzdCAgICAgOiBwYXNzZWQK
aW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogNjQK
ZGlnZXN0c2l6ZSAgIDogMjAKCm5hbWUgICAgICAgICA6IG1kNApkcml2ZXIgICAgICAgOiBtZDQt
Z2VuZXJpYwptb2R1bGUgICAgICAgOiBtZDQKcHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAg
OiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAg
OiBzaGFzaApibG9ja3NpemUgICAgOiA2NApkaWdlc3RzaXplICAgOiAxNgoKbmFtZSAgICAgICAg
IDogeHRzKGFlcykKZHJpdmVyICAgICAgIDogeHRzKGVjYihhZXMtZ2VuZXJpYykpCm1vZHVsZSAg
ICAgICA6IHh0cwpwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMwpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5
bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMTYKbWluIGtleXNpemUgIDogMzIKbWF4IGtl
eXNpemUgIDogNjQKaXZzaXplICAgICAgIDogMTYKY2h1bmtzaXplICAgIDogMTYKd2Fsa3NpemUg
ICAgIDogMTYKCm5hbWUgICAgICAgICA6IGVjYihhZXMpCmRyaXZlciAgICAgICA6IGVjYihhZXMt
Z2VuZXJpYykKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQg
ICAgICAgOiAzCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBza2NpcGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxNgptaW4g
a2V5c2l6ZSAgOiAxNgptYXgga2V5c2l6ZSAgOiAzMgppdnNpemUgICAgICAgOiAwCmNodW5rc2l6
ZSAgICA6IDE2CndhbGtzaXplICAgICA6IDE2CgpuYW1lICAgICAgICAgOiBjYmMoYmxvd2Zpc2gp
CmRyaXZlciAgICAgICA6IGNiYyhibG93ZmlzaC1hc20pCm1vZHVsZSAgICAgICA6IGtlcm5lbApw
cmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQK
aW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDog
bm8KYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA0Cm1heCBrZXlzaXplICA6IDU2Cml2
c2l6ZSAgICAgICA6IDgKY2h1bmtzaXplICAgIDogOAp3YWxrc2l6ZSAgICAgOiA4CgpuYW1lICAg
ICAgICAgOiBibG93ZmlzaApkcml2ZXIgICAgICAgOiBibG93ZmlzaC1nZW5lcmljCm1vZHVsZSAg
ICAgICA6IGJsb3dmaXNoX2dlbmVyaWMKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IGNpcGhlcgpibG9ja3NpemUgICAgOiA4Cm1pbiBrZXlzaXplICA6IDQKbWF4IGtleXNpemUgIDog
NTYKCm5hbWUgICAgICAgICA6IGNiYyhibG93ZmlzaCkKZHJpdmVyICAgICAgIDogY2JjLWJsb3dm
aXNoLWFzbQptb2R1bGUgICAgICAgOiBibG93ZmlzaF94ODZfNjQKcHJpb3JpdHkgICAgIDogMzAw
CnJlZmNudCAgICAgICA6IDQKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6
IDgKbWluIGtleXNpemUgIDogNAptYXgga2V5c2l6ZSAgOiA1NgppdnNpemUgICAgICAgOiA4CmNo
dW5rc2l6ZSAgICA6IDgKd2Fsa3NpemUgICAgIDogOAoKbmFtZSAgICAgICAgIDogZWNiKGJsb3dm
aXNoKQpkcml2ZXIgICAgICAgOiBlY2ItYmxvd2Zpc2gtYXNtCm1vZHVsZSAgICAgICA6IGJsb3dm
aXNoX3g4Nl82NApwcmlvcml0eSAgICAgOiAzMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAg
ICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2tjaXBoZXIKYXN5
bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA0Cm1heCBrZXlz
aXplICA6IDU2Cml2c2l6ZSAgICAgICA6IDAKY2h1bmtzaXplICAgIDogOAp3YWxrc2l6ZSAgICAg
OiA4CgpuYW1lICAgICAgICAgOiBibG93ZmlzaApkcml2ZXIgICAgICAgOiBibG93ZmlzaC1hc20K
bW9kdWxlICAgICAgIDogYmxvd2Zpc2hfeDg2XzY0CnByaW9yaXR5ICAgICA6IDIwMApyZWZjbnQg
ICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAg
ICAgICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogOAptaW4ga2V5c2l6ZSAgOiA0Cm1heCBrZXlz
aXplICA6IDU2CgpuYW1lICAgICAgICAgOiBjcmM2NC1yb2Nrc29mdApkcml2ZXIgICAgICAgOiBj
cmM2NC1yb2Nrc29mdC1nZW5lcmljCm1vZHVsZSAgICAgICA6IGNyYzY0X3JvY2tzb2Z0X2dlbmVy
aWMKcHJpb3JpdHkgICAgIDogMjAwCnJlZmNudCAgICAgICA6IDIKc2VsZnRlc3QgICAgIDogcGFz
c2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6
IDEKZGlnZXN0c2l6ZSAgIDogOAoKbmFtZSAgICAgICAgIDogY3JjdDEwZGlmCmRyaXZlciAgICAg
ICA6IGNyY3QxMGRpZi1wY2xtdWwKbW9kdWxlICAgICAgIDogY3JjdDEwZGlmX3BjbG11bApwcmlv
cml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDogMgpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50
ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMQpkaWdl
c3RzaXplICAgOiAyCgpuYW1lICAgICAgICAgOiBjcmMzMgpkcml2ZXIgICAgICAgOiBjcmMzMi1w
Y2xtdWwKbW9kdWxlICAgICAgIDogY3JjMzJfcGNsbXVsCnByaW9yaXR5ICAgICA6IDIwMApyZWZj
bnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAgOiAxCmRpZ2VzdHNpemUgICA6IDQKCm5hbWUg
ICAgICAgICA6IGNyYzMyYwpkcml2ZXIgICAgICAgOiBjcmMzMmMtaW50ZWwKbW9kdWxlICAgICAg
IDogY3JjMzJjX2ludGVsCnByaW9yaXR5ICAgICA6IDIwMApyZWZjbnQgICAgICAgOiA2CnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApi
bG9ja3NpemUgICAgOiAxCmRpZ2VzdHNpemUgICA6IDQKCm5hbWUgICAgICAgICA6IHBvbHl2YWwK
ZHJpdmVyICAgICAgIDogcG9seXZhbC1jbG11bG5pCm1vZHVsZSAgICAgICA6IHBvbHl2YWxfY2xt
dWxuaQpwcmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBw
YXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAg
IDogMTYKZGlnZXN0c2l6ZSAgIDogMTYKCm5hbWUgICAgICAgICA6IHBvbHl2YWwKZHJpdmVyICAg
ICAgIDogcG9seXZhbC1nZW5lcmljCm1vZHVsZSAgICAgICA6IHBvbHl2YWxfZ2VuZXJpYwpwcmlv
cml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50
ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMTYKZGln
ZXN0c2l6ZSAgIDogMTYKCm5hbWUgICAgICAgICA6IF9fZ2hhc2gKZHJpdmVyICAgICAgIDogY3J5
cHRkKF9fZ2hhc2gtcGNsbXVscWRxbmkpCm1vZHVsZSAgICAgICA6IGNyeXB0ZApwcmlvcml0eSAg
ICAgOiA1MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAg
ICAgOiB5ZXMKdHlwZSAgICAgICAgIDogYWhhc2gKYXN5bmMgICAgICAgIDogeWVzCmJsb2Nrc2l6
ZSAgICA6IDE2CmRpZ2VzdHNpemUgICA6IDE2CgpuYW1lICAgICAgICAgOiBnaGFzaApkcml2ZXIg
ICAgICAgOiBnaGFzaC1jbG11bG5pCm1vZHVsZSAgICAgICA6IGdoYXNoX2NsbXVsbmlfaW50ZWwK
cHJpb3JpdHkgICAgIDogNDAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2Vk
CmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGFoYXNoCmFzeW5jICAgICAgICA6IHll
cwpibG9ja3NpemUgICAgOiAxNgpkaWdlc3RzaXplICAgOiAxNgoKbmFtZSAgICAgICAgIDogX19n
aGFzaApkcml2ZXIgICAgICAgOiBfX2doYXNoLXBjbG11bHFkcW5pCm1vZHVsZSAgICAgICA6IGdo
YXNoX2NsbXVsbmlfaW50ZWwKcHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0
ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiB5ZXMKdHlwZSAgICAgICAgIDogc2hhc2gK
YmxvY2tzaXplICAgIDogMTYKZGlnZXN0c2l6ZSAgIDogMTYKCm5hbWUgICAgICAgICA6IHNoYTM4
NApkcml2ZXIgICAgICAgOiBzaGEzODQtYXZ4Mgptb2R1bGUgICAgICAgOiBzaGE1MTJfc3NzZTMK
cHJpb3JpdHkgICAgIDogMTcwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2Vk
CmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDEy
OApkaWdlc3RzaXplICAgOiA0OAoKbmFtZSAgICAgICAgIDogc2hhNTEyCmRyaXZlciAgICAgICA6
IHNoYTUxMi1hdngyCm1vZHVsZSAgICAgICA6IHNoYTUxMl9zc3NlMwpwcmlvcml0eSAgICAgOiAx
NzAKcmVmY250ICAgICAgIDogMgpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDog
bm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMTI4CmRpZ2VzdHNpemUgICA6
IDY0CgpuYW1lICAgICAgICAgOiBzaGEzODQKZHJpdmVyICAgICAgIDogc2hhMzg0LWF2eAptb2R1
bGUgICAgICAgOiBzaGE1MTJfc3NzZTMKcHJpb3JpdHkgICAgIDogMTYwCnJlZmNudCAgICAgICA6
IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6
IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDEyOApkaWdlc3RzaXplICAgOiA0OAoKbmFtZSAgICAgICAg
IDogc2hhNTEyCmRyaXZlciAgICAgICA6IHNoYTUxMi1hdngKbW9kdWxlICAgICAgIDogc2hhNTEy
X3Nzc2UzCnByaW9yaXR5ICAgICA6IDE2MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUg
ICAgOiAxMjgKZGlnZXN0c2l6ZSAgIDogNjQKCm5hbWUgICAgICAgICA6IHNoYTM4NApkcml2ZXIg
ICAgICAgOiBzaGEzODQtc3NzZTMKbW9kdWxlICAgICAgIDogc2hhNTEyX3Nzc2UzCnByaW9yaXR5
ICAgICA6IDE1MApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5h
bCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAgOiAxMjgKZGlnZXN0
c2l6ZSAgIDogNDgKCm5hbWUgICAgICAgICA6IHNoYTUxMgpkcml2ZXIgICAgICAgOiBzaGE1MTIt
c3NzZTMKbW9kdWxlICAgICAgIDogc2hhNTEyX3Nzc2UzCnByaW9yaXR5ICAgICA6IDE1MApyZWZj
bnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAgOiAxMjgKZGlnZXN0c2l6ZSAgIDogNjQKCm5h
bWUgICAgICAgICA6IGN0cihhZXMpCmRyaXZlciAgICAgICA6IGN0cihhZXMtZ2VuZXJpYykKbW9k
dWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBza2Np
cGhlcgphc3luYyAgICAgICAgOiBubwpibG9ja3NpemUgICAgOiAxCm1pbiBrZXlzaXplICA6IDE2
Cm1heCBrZXlzaXplICA6IDMyCml2c2l6ZSAgICAgICA6IDE2CmNodW5rc2l6ZSAgICA6IDE2Cndh
bGtzaXplICAgICA6IDE2CgpuYW1lICAgICAgICAgOiBobWFjKHNoYTI1NikKZHJpdmVyICAgICAg
IDogaG1hYyhzaGEyNTYtZ2VuZXJpYykKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAg
ICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAg
ICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAgOiA2NApkaWdlc3RzaXpl
ICAgOiAzMgoKbmFtZSAgICAgICAgIDogY2JjKGFlcykKZHJpdmVyICAgICAgIDogY2JjKGFlcy1n
ZW5lcmljKQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAg
ICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAg
ICAgICA6IHNrY2lwaGVyCmFzeW5jICAgICAgICA6IG5vCmJsb2Nrc2l6ZSAgICA6IDE2Cm1pbiBr
ZXlzaXplICA6IDE2Cm1heCBrZXlzaXplICA6IDMyCml2c2l6ZSAgICAgICA6IDE2CmNodW5rc2l6
ZSAgICA6IDE2CndhbGtzaXplICAgICA6IDE2CgpuYW1lICAgICAgICAgOiB6bGliLWRlZmxhdGUK
ZHJpdmVyICAgICAgIDogemxpYi1kZWZsYXRlLXNjb21wCm1vZHVsZSAgICAgICA6IGRlZmxhdGUK
cHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzY29tcAoKbmFtZSAgICAgICAgIDogZGVm
bGF0ZQpkcml2ZXIgICAgICAgOiBkZWZsYXRlLXNjb21wCm1vZHVsZSAgICAgICA6IGRlZmxhdGUK
cHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZApp
bnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzY29tcAoKbmFtZSAgICAgICAgIDogZGVm
bGF0ZQpkcml2ZXIgICAgICAgOiBkZWZsYXRlLWdlbmVyaWMKbW9kdWxlICAgICAgIDogZGVmbGF0
ZQpwcmlvcml0eSAgICAgOiAwCnJlZmNudCAgICAgICA6IDIKc2VsZnRlc3QgICAgIDogcGFzc2Vk
CmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IGNvbXByZXNzaW9uCgpuYW1lICAgICAg
ICAgOiBwa2NzMXBhZChyc2Esc2hhNTEyKQpkcml2ZXIgICAgICAgOiBwa2NzMXBhZChyc2EtZ2Vu
ZXJpYyxzaGE1MTIpCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAKcmVm
Y250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogYWtjaXBoZXIKCm5hbWUgICAgICAgICA6IGppdHRlcmVudHJvcHlfcm5nCmRy
aXZlciAgICAgICA6IGppdHRlcmVudHJvcHlfcm5nCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlv
cml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDogMgpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50
ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAKCm5hbWUg
ICAgICAgICA6IGdoYXNoCmRyaXZlciAgICAgICA6IGdoYXNoLWdlbmVyaWMKbW9kdWxlICAgICAg
IDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAg
ICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3Np
emUgICAgOiAxNgpkaWdlc3RzaXplICAgOiAxNgoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZl
ciAgICAgICA6IGRyYmdfbm9wcl9obWFjX3NoYTUxMgptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJp
b3JpdHkgICAgIDogMjIxCnJlZmNudCAgICAgICA6IDIKc2VsZnRlc3QgICAgIDogcGFzc2VkCmlu
dGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHJuZwpzZWVkc2l6ZSAgICAgOiAwCgpuYW1l
ICAgICAgICAgOiBzdGRybmcKZHJpdmVyICAgICAgIDogZHJiZ19ub3ByX2htYWNfc2hhMjU2Cm1v
ZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMjAKcmVmY250ICAgICAgIDogMQpz
ZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5n
CnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAgICAgICA6IHN0ZHJuZwpkcml2ZXIgICAgICAgOiBk
cmJnX25vcHJfaG1hY19zaGEzODQKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6
IDIxOQpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAg
OiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDog
c3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfbm9wcl9obWFjX3NoYTEKbW9kdWxlICAgICAgIDog
a2VybmVsCnByaW9yaXR5ICAgICA6IDIxOApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAg
IDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfbm9wcl9zaGEy
NTYKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDIxNwpyZWZjbnQgICAgICAg
OiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAg
OiBybmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAg
ICA6IGRyYmdfbm9wcl9zaGE1MTIKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6
IDIxNgpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAg
OiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDog
c3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfbm9wcl9zaGEzODQKbW9kdWxlICAgICAgIDoga2Vy
bmVsCnByaW9yaXR5ICAgICA6IDIxNQpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBh
c3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAgIDog
MAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfbm9wcl9zaGExCm1v
ZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMTQKcmVmY250ICAgICAgIDogMQpz
ZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5n
CnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAgICAgICA6IHN0ZHJuZwpkcml2ZXIgICAgICAgOiBk
cmJnX25vcHJfY3RyX2FlczI1Ngptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDog
MjEzCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6
IG5vCnR5cGUgICAgICAgICA6IHJuZwpzZWVkc2l6ZSAgICAgOiAwCgpuYW1lICAgICAgICAgOiBz
dGRybmcKZHJpdmVyICAgICAgIDogZHJiZ19ub3ByX2N0cl9hZXMxOTIKbW9kdWxlICAgICAgIDog
a2VybmVsCnByaW9yaXR5ICAgICA6IDIxMgpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6
IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNpemUgICAg
IDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfbm9wcl9jdHJf
YWVzMTI4Cm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMTEKcmVmY250ICAg
ICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAg
ICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAgICAgICA6IHN0ZHJuZwpkcml2ZXIg
ICAgICAgOiBkcmJnX3ByX2htYWNfc2hhNTEyCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0
eSAgICAgOiAyMTAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJu
YWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAg
ICAgICA6IHN0ZHJuZwpkcml2ZXIgICAgICAgOiBkcmJnX3ByX2htYWNfc2hhMjU2Cm1vZHVsZSAg
ICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMDkKcmVmY250ICAgICAgIDogMQpzZWxmdGVz
dCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5nCnNlZWRz
aXplICAgICA6IDAKCm5hbWUgICAgICAgICA6IHN0ZHJuZwpkcml2ZXIgICAgICAgOiBkcmJnX3By
X2htYWNfc2hhMzg0Cm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMDgKcmVm
Y250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAgICAgICA6IHN0ZHJuZwpk
cml2ZXIgICAgICAgOiBkcmJnX3ByX2htYWNfc2hhMQptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJp
b3JpdHkgICAgIDogMjA3CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmlu
dGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHJuZwpzZWVkc2l6ZSAgICAgOiAwCgpuYW1l
ICAgICAgICAgOiBzdGRybmcKZHJpdmVyICAgICAgIDogZHJiZ19wcl9zaGEyNTYKbW9kdWxlICAg
ICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDIwNgpyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0
ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBybmcKc2VlZHNp
emUgICAgIDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6IGRyYmdfcHJf
c2hhNTEyCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAyMDUKcmVmY250ICAg
ICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAg
ICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAKCm5hbWUgICAgICAgICA6IHN0ZHJuZwpkcml2ZXIg
ICAgICAgOiBkcmJnX3ByX3NoYTM4NAptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAg
IDogMjA0CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAg
ICA6IG5vCnR5cGUgICAgICAgICA6IHJuZwpzZWVkc2l6ZSAgICAgOiAwCgpuYW1lICAgICAgICAg
OiBzdGRybmcKZHJpdmVyICAgICAgIDogZHJiZ19wcl9zaGExCm1vZHVsZSAgICAgICA6IGtlcm5l
bApwcmlvcml0eSAgICAgOiAyMDMKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNz
ZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6IDAK
Cm5hbWUgICAgICAgICA6IHN0ZHJuZwpkcml2ZXIgICAgICAgOiBkcmJnX3ByX2N0cl9hZXMyNTYK
bW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDIwMgpyZWZjbnQgICAgICAgOiAx
CnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBy
bmcKc2VlZHNpemUgICAgIDogMAoKbmFtZSAgICAgICAgIDogc3Rkcm5nCmRyaXZlciAgICAgICA6
IGRyYmdfcHJfY3RyX2FlczE5Mgptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDog
MjAxCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6
IG5vCnR5cGUgICAgICAgICA6IHJuZwpzZWVkc2l6ZSAgICAgOiAwCgpuYW1lICAgICAgICAgOiBz
dGRybmcKZHJpdmVyICAgICAgIDogZHJiZ19wcl9jdHJfYWVzMTI4Cm1vZHVsZSAgICAgICA6IGtl
cm5lbApwcmlvcml0eSAgICAgOiAyMDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBw
YXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogcm5nCnNlZWRzaXplICAgICA6
IDAKCm5hbWUgICAgICAgICA6IGx6by1ybGUKZHJpdmVyICAgICAgIDogbHpvLXJsZS1zY29tcApt
b2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNl
bGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzY29t
cAoKbmFtZSAgICAgICAgIDogbHpvLXJsZQpkcml2ZXIgICAgICAgOiBsem8tcmxlLWdlbmVyaWMK
bW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDAKcmVmY250ICAgICAgIDogMQpz
ZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogY29t
cHJlc3Npb24KCm5hbWUgICAgICAgICA6IGx6bwpkcml2ZXIgICAgICAgOiBsem8tc2NvbXAKbW9k
dWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDAKcmVmY250ICAgICAgIDogMQpzZWxm
dGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDogc2NvbXAK
Cm5hbWUgICAgICAgICA6IGx6bwpkcml2ZXIgICAgICAgOiBsem8tZ2VuZXJpYwptb2R1bGUgICAg
ICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAg
ICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBjb21wcmVzc2lvbgoK
bmFtZSAgICAgICAgIDogY3JjdDEwZGlmCmRyaXZlciAgICAgICA6IGNyY3QxMGRpZi1nZW5lcmlj
Cm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAgIDog
MQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAgIDog
c2hhc2gKYmxvY2tzaXplICAgIDogMQpkaWdlc3RzaXplICAgOiAyCgpuYW1lICAgICAgICAgOiBj
cmMzMmMKZHJpdmVyICAgICAgIDogY3JjMzJjLWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVs
CnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3Nl
ZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3NpemUgICAgOiAx
CmRpZ2VzdHNpemUgICA6IDQKCm5hbWUgICAgICAgICA6IGFlcwpkcml2ZXIgICAgICAgOiBhZXMt
Z2VuZXJpYwptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAwCnJlZmNudCAg
ICAgICA6IDUKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAg
ICAgICA6IGNpcGhlcgpibG9ja3NpemUgICAgOiAxNgptaW4ga2V5c2l6ZSAgOiAxNgptYXgga2V5
c2l6ZSAgOiAzMgoKbmFtZSAgICAgICAgIDogc2hhMzg0CmRyaXZlciAgICAgICA6IHNoYTM4NC1n
ZW5lcmljCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAg
ICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAg
ICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMTI4CmRpZ2VzdHNpemUgICA6IDQ4CgpuYW1lICAg
ICAgICAgOiBzaGE1MTIKZHJpdmVyICAgICAgIDogc2hhNTEyLWdlbmVyaWMKbW9kdWxlICAgICAg
IDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiAyCnNlbGZ0ZXN0ICAg
ICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAgICAgOiBzaGFzaApibG9ja3Np
emUgICAgOiAxMjgKZGlnZXN0c2l6ZSAgIDogNjQKCm5hbWUgICAgICAgICA6IHNoYTIyNApkcml2
ZXIgICAgICAgOiBzaGEyMjQtZ2VuZXJpYwptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkg
ICAgIDogMTAwCnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFs
ICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAgICA6IDY0CmRpZ2VzdHNp
emUgICA6IDI4CgpuYW1lICAgICAgICAgOiBzaGEyNTYKZHJpdmVyICAgICAgIDogc2hhMjU2LWdl
bmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAg
ICAgOiAyCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBlICAgICAg
ICAgOiBzaGFzaApibG9ja3NpemUgICAgOiA2NApkaWdlc3RzaXplICAgOiAzMgoKbmFtZSAgICAg
ICAgIDogc2hhMQpkcml2ZXIgICAgICAgOiBzaGExLWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2Vy
bmVsCnByaW9yaXR5ICAgICA6IDEwMApyZWZjbnQgICAgICAgOiA0MTIKc2VsZnRlc3QgICAgIDog
cGFzc2VkCmludGVybmFsICAgICA6IG5vCnR5cGUgICAgICAgICA6IHNoYXNoCmJsb2Nrc2l6ZSAg
ICA6IDY0CmRpZ2VzdHNpemUgICA6IDIwCgpuYW1lICAgICAgICAgOiBtZDUKZHJpdmVyICAgICAg
IDogbWQ1LWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAgICA6IDAKcmVm
Y250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlw
ZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogNjQKZGlnZXN0c2l6ZSAgIDogMTYKCm5h
bWUgICAgICAgICA6IGVjYihjaXBoZXJfbnVsbCkKZHJpdmVyICAgICAgIDogZWNiLWNpcGhlcl9u
dWxsCm1vZHVsZSAgICAgICA6IGtlcm5lbApwcmlvcml0eSAgICAgOiAxMDAKcmVmY250ICAgICAg
IDogMgpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAgIDogbm8KdHlwZSAgICAgICAg
IDogc2tjaXBoZXIKYXN5bmMgICAgICAgIDogbm8KYmxvY2tzaXplICAgIDogMQptaW4ga2V5c2l6
ZSAgOiAwCm1heCBrZXlzaXplICA6IDAKaXZzaXplICAgICAgIDogMApjaHVua3NpemUgICAgOiAx
CndhbGtzaXplICAgICA6IDEKCm5hbWUgICAgICAgICA6IGRpZ2VzdF9udWxsCmRyaXZlciAgICAg
ICA6IGRpZ2VzdF9udWxsLWdlbmVyaWMKbW9kdWxlICAgICAgIDoga2VybmVsCnByaW9yaXR5ICAg
ICA6IDAKcmVmY250ICAgICAgIDogMQpzZWxmdGVzdCAgICAgOiBwYXNzZWQKaW50ZXJuYWwgICAg
IDogbm8KdHlwZSAgICAgICAgIDogc2hhc2gKYmxvY2tzaXplICAgIDogMQpkaWdlc3RzaXplICAg
OiAwCgpuYW1lICAgICAgICAgOiBjb21wcmVzc19udWxsCmRyaXZlciAgICAgICA6IGNvbXByZXNz
X251bGwtZ2VuZXJpYwptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMApyZWZj
bnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5hbCAgICAgOiBubwp0eXBl
ICAgICAgICAgOiBjb21wcmVzc2lvbgoKbmFtZSAgICAgICAgIDogY2lwaGVyX251bGwKZHJpdmVy
ICAgICAgIDogY2lwaGVyX251bGwtZ2VuZXJpYwptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3Jp
dHkgICAgIDogMApyZWZjbnQgICAgICAgOiAxCnNlbGZ0ZXN0ICAgICA6IHBhc3NlZAppbnRlcm5h
bCAgICAgOiBubwp0eXBlICAgICAgICAgOiBjaXBoZXIKYmxvY2tzaXplICAgIDogMQptaW4ga2V5
c2l6ZSAgOiAwCm1heCBrZXlzaXplICA6IDAKCm5hbWUgICAgICAgICA6IHJzYQpkcml2ZXIgICAg
ICAgOiByc2EtZ2VuZXJpYwptb2R1bGUgICAgICAgOiBrZXJuZWwKcHJpb3JpdHkgICAgIDogMTAw
CnJlZmNudCAgICAgICA6IDEKc2VsZnRlc3QgICAgIDogcGFzc2VkCmludGVybmFsICAgICA6IG5v
CnR5cGUgICAgICAgICA6IGFrY2lwaGVyCgo=
--00000000000003d50d060c500f41--

